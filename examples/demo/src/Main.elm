module Main exposing (main)

import Assets exposing (Assets)
import Browser exposing (Document)
import Browser.Dom exposing (Viewport, getViewport)
import Ecs exposing (Ecs)
import Entity exposing (Entity)
import Frame exposing (Frame)
import History exposing (History)
import Html exposing (Html, text)
import Random
import State exposing (State)
import Systems
import Task
import Time exposing (Posix, posixToMillis)
import WebGL.Texture as Texture exposing (Error)



-- MODEL --


type Model
    = InitPending
    | InitFailure Error
    | InitSuccess SuccessModel


type alias SuccessModel =
    { ecs : Ecs Entity
    , state : State
    , frame : Frame
    , history : History
    }


type alias InitData =
    { assets : Assets
    , posix : Posix
    , viewport : Viewport
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( InitPending
    , Task.map3 InitData
        Assets.load
        Time.now
        getViewport
        |> Task.attempt InitReceived
    )


initSuccess : InitData -> Model
initSuccess { assets, posix, viewport } =
    let
        screen =
            { width = round viewport.viewport.width
            , height = round viewport.viewport.height
            }

        seed =
            Random.initialSeed (posixToMillis posix)

        ( ecs, state ) =
            Entity.initEcs (State.init assets seed screen)
    in
    InitSuccess
        { ecs = ecs
        , state = state
        , frame = Frame.init (1.0 / 20.0)
        , history = History.empty 500
        }



-- UPDATE --


type Msg
    = InitReceived (Result Error InitData)
    | StateMsg State.Msg
    | FrameMsg Frame.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( model, msg ) of
        ( InitPending, InitReceived (Err error) ) ->
            ( InitFailure error, Cmd.none )

        ( InitPending, InitReceived (Ok data) ) ->
            ( initSuccess data, Cmd.none )

        ( InitFailure error, _ ) ->
            ( model, Cmd.none )

        ( InitSuccess successModel, StateMsg stateMsg ) ->
            let
                ( state, outMsg ) =
                    State.update stateMsg successModel.state
            in
            case outMsg of
                State.NoOp ->
                    ( InitSuccess { successModel | state = state }
                    , Cmd.none
                    )

                State.PauseToggled ->
                    ( InitSuccess
                        { successModel
                            | state = state
                            , frame = Frame.togglePaused successModel.frame
                        }
                    , Cmd.none
                    )

        ( InitSuccess successModel, FrameMsg frameMsg ) ->
            let
                ( frame, outMsg ) =
                    Frame.update frameMsg successModel.frame
            in
            case outMsg of
                Frame.NoOp ->
                    ( InitSuccess { successModel | frame = frame }
                    , Cmd.none
                    )

                Frame.Update data maybeStats cmd ->
                    let
                        ( ecs, state ) =
                            Systems.update
                                successModel.ecs
                                (updateState data successModel.state)

                        history =
                            case maybeStats of
                                Nothing ->
                                    successModel.history

                                Just stats ->
                                    History.add
                                        { index = stats.index
                                        , updateTime = stats.updateTime
                                        , frameTime = stats.frameTime
                                        , entityCount =
                                            Ecs.size successModel.ecs
                                        }
                                        successModel.history

                        newFrame =
                            if
                                state.test
                                    && not (Frame.isPaused frame)
                                    && (History.getFps history < 30)
                            then
                                Frame.togglePaused frame

                            else
                                frame
                    in
                    ( InitSuccess
                        { ecs = ecs
                        , state = state
                        , frame = newFrame
                        , history = history
                        }
                    , Cmd.map FrameMsg cmd
                    )

        _ ->
            ( model, Cmd.none )


updateState : { deltaTime : Float, accumulatedTime : Float } -> State -> State
updateState data state =
    { state
        | time = data.accumulatedTime
        , deltaTime = data.deltaTime
    }



-- SUBSCRIPTIONS --


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        InitSuccess { state, frame } ->
            Sub.batch
                [ Sub.map StateMsg (State.subscriptions state)
                , Sub.map FrameMsg (Frame.subscriptions frame)
                ]

        _ ->
            Sub.none



-- VIEW --


view : Model -> Document Msg
view model =
    { title = "Ecs Example"
    , body =
        case model of
            InitPending ->
                [ text "loading..." ]

            InitFailure error ->
                viewError error

            InitSuccess { ecs, state, frame, history } ->
                [ Systems.view frame history ecs state ]
    }


viewError : Error -> List (Html Msg)
viewError error =
    case error of
        Texture.LoadError ->
            [ text "could not load texture" ]

        Texture.SizeError width height ->
            [ text <|
                "could not load texture with size "
                    ++ String.fromInt width
                    ++ "x"
                    ++ String.fromInt height
            ]



-- MAIN --


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

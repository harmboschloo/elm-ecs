module Main exposing (main)

import Assets exposing (Assets)
import Browser exposing (Document)
import Browser.Dom exposing (Viewport, getViewport)
import Context exposing (Context)
import Ecs exposing (Ecs)
import Entities
import Frame exposing (Frame)
import History exposing (History)
import Html exposing (Html, text)
import Random
import Systems
import Task
import Time exposing (Posix, posixToMillis)
import WebGL.Texture as Texture exposing (Error)



-- MODEL --


type InitState
    = InitPending
    | InitError Error
    | InitOk Model


type alias Model =
    { assets : Assets
    , context : Context
    , ecs : Ecs
    , frame : Frame
    , history : History
    }


type alias Screen =
    { width : Int
    , height : Int
    }


type alias InitData =
    { assets : Assets
    , posix : Posix
    , viewport : Viewport
    }


init : () -> ( InitState, Cmd Msg )
init _ =
    ( InitPending
    , Task.map3 InitData
        Assets.load
        Time.now
        getViewport
        |> Task.attempt InitReceived
    )


initModel : InitData -> Model
initModel { assets, posix, viewport } =
    let
        screen =
            { width = round viewport.viewport.width
            , height = round viewport.viewport.height
            }

        seed =
            Random.initialSeed (posixToMillis posix)

        ( ecs, context ) =
            Entities.init (Context.init assets seed screen)
    in
    { assets = assets
    , context = context
    , ecs = ecs
    , frame = Frame.init (1.0 / 20.0)
    , history = History.empty 500
    }



-- UPDATE --


type Msg
    = InitReceived (Result Error InitData)
    | ContextMsg Context.Msg
    | FrameMsg Frame.Msg


update : Msg -> InitState -> ( InitState, Cmd Msg )
update msg state =
    case ( state, msg ) of
        ( InitPending, InitReceived (Err error) ) ->
            ( InitError error, Cmd.none )

        ( InitPending, InitReceived (Ok data) ) ->
            ( InitOk (initModel data), Cmd.none )

        ( InitError error, _ ) ->
            ( state, Cmd.none )

        ( InitOk model, ContextMsg contextMsg ) ->
            let
                ( context, outMsg ) =
                    Context.update contextMsg model.context
            in
            case outMsg of
                Context.NoOp ->
                    ( InitOk { model | context = context }, Cmd.none )

                Context.PauseToggled ->
                    ( InitOk
                        { model
                            | context = context
                            , frame = Frame.togglePaused model.frame
                        }
                    , Cmd.none
                    )

        ( InitOk model, FrameMsg frameMsg ) ->
            let
                ( frame, outMsg ) =
                    Frame.update frameMsg model.frame
            in
            case outMsg of
                Frame.NoOp ->
                    ( InitOk { model | frame = frame }, Cmd.none )

                Frame.Update data maybeStats cmd ->
                    let
                        ( ecs, context ) =
                            Systems.update
                                (updateContext data model.context)
                                model.ecs

                        history =
                            case maybeStats of
                                Nothing ->
                                    model.history

                                Just stats ->
                                    History.add
                                        { index = stats.index
                                        , updateTime = stats.updateTime
                                        , frameTime = stats.frameTime
                                        , entityCount = Ecs.activeSize model.ecs
                                        }
                                        model.history
                    in
                    ( InitOk
                        { model
                            | context = context
                            , ecs = ecs
                            , frame = frame
                            , history = history
                        }
                    , Cmd.map FrameMsg cmd
                    )

        _ ->
            ( state, Cmd.none )


updateContext : { deltaTime : Float, accumulatedTime : Float } -> Context -> Context
updateContext data context =
    { context
        | time = data.accumulatedTime
        , deltaTime = data.deltaTime
    }



-- SUBSCRIPTIONS --


subscriptions : InitState -> Sub Msg
subscriptions state =
    case state of
        InitOk model ->
            Sub.batch
                [ Sub.map ContextMsg (Context.subscriptions model.context)
                , Sub.map FrameMsg (Frame.subscriptions model.frame)
                ]

        _ ->
            Sub.none



-- VIEW --


view : InitState -> Document Msg
view state =
    { title = "Ecs Example"
    , body =
        case state of
            InitPending ->
                [ text "loading..." ]

            InitError error ->
                viewError error

            InitOk internalModel ->
                viewOk internalModel
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


viewOk : Model -> List (Html Msg)
viewOk model =
    [ Systems.view model.frame model.history model.context model.ecs ]



-- MAIN --


main : Program () InitState Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

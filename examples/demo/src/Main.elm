module Main exposing (main)

import Assets exposing (Assets)
import Browser exposing (Document)
import Browser.Dom exposing (Viewport, getViewport)
import Entities
import Frame exposing (Frame)
import Game exposing (Game)
import History exposing (History)
import Html exposing (Html, text)
import Random
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
    { game : Game
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

        game =
            Entities.init (Game.init assets seed screen)
    in
    InitSuccess
        { game = game
        , frame = Frame.init (1.0 / 20.0)
        , history = History.empty 500
        }



-- UPDATE --


type Msg
    = InitReceived (Result Error InitData)
    | GameMsg Game.Msg
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

        ( InitSuccess successModel, GameMsg gameMsg ) ->
            let
                game =
                    Game.updateMsg gameMsg successModel.game

                frame =
                    if
                        Game.isPaused game
                            /= Frame.isPaused successModel.frame
                    then
                        Frame.togglePaused successModel.frame

                    else
                        successModel.frame
            in
            ( InitSuccess
                { successModel
                    | game = game
                    , frame = frame
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
                        game =
                            successModel.game
                                |> Game.setTiming data
                                |> Systems.update

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
                                            Game.entityCount successModel.game
                                        }
                                        successModel.history

                        newFrame =
                            if
                                Game.isTestEnabled game
                                    && not (Frame.isPaused frame)
                                    && (History.getFps history < 30)
                            then
                                Frame.togglePaused frame

                            else
                                frame
                    in
                    ( InitSuccess
                        { game = game
                        , frame = newFrame
                        , history = history
                        }
                    , Cmd.map FrameMsg cmd
                    )

        _ ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS --


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        InitSuccess { game, frame } ->
            Sub.batch
                [ Sub.map GameMsg (Game.subscriptions game)
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

            InitSuccess { game, frame, history } ->
                [ Systems.view frame history game ]
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

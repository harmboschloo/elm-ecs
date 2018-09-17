module Main exposing (main)

import Assets exposing (Assets)
import Browser exposing (Document)
import Browser.Dom exposing (Viewport, getViewport)
import Browser.Events
    exposing
        ( onAnimationFrameDelta
        , onKeyDown
        , onKeyUp
        , onResize
        )
import Ecs exposing (Ecs)
import Ecs.Entities as Entities
import Ecs.Systems as Systems
import Ecs.Systems.KeyControls as KeyControls
    exposing
        ( KeyChange
        , Keys
        , keyDownDecoder
        , keyUpDecoder
        )
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Html.Events
import Json.Decode as Decode
import KeyCode exposing (KeyCode)
import Task
import WebGL.Texture as Texture exposing (Error)
import World exposing (World)



-- MODEL --


type InitState
    = InitPending
    | InitError Error
    | InitOk Model


type alias Model =
    { assets : Assets
    , ecs : Ecs
    , screen : Screen
    , keys : Keys
    , deltaTime : Float
    , stepCount : Int
    , running : Bool
    }


type alias Screen =
    { width : Int
    , height : Int
    }


type alias InitData =
    { assets : Assets
    , viewport : Viewport
    }


init : () -> ( InitState, Cmd Msg )
init _ =
    ( InitPending
    , Task.map2 InitData
        Assets.load
        getViewport
        |> Task.attempt InitReceived
    )


initModel : InitData -> Model
initModel { assets, viewport } =
    let
        screen =
            { width = round viewport.viewport.width
            , height = round viewport.viewport.height
            }

        world =
            getWorld assets screen
    in
    { assets = assets
    , ecs = Entities.init assets world
    , screen = screen
    , keys = KeyControls.initKeys
    , deltaTime = 0
    , stepCount = 0
    , running = True
    }


getWorld : Assets -> Screen -> World
getWorld assets screen =
    { width = 2 * toFloat screen.width
    , height = 2 * toFloat screen.height
    , background = assets.background
    }



-- UPDATE --


type Msg
    = InitReceived (Result Error InitData)
    | AnimationFrameStarted Float
    | WindowSizeChanged Int Int
    | KeyChanged KeyChange
    | KeyReleased KeyCode


update : Msg -> InitState -> ( InitState, Cmd Msg )
update msg state =
    case ( state, msg ) of
        ( InitPending, InitReceived (Err error) ) ->
            ( InitError error, Cmd.none )

        ( InitPending, InitReceived (Ok data) ) ->
            ( InitOk (initModel data), Cmd.none )

        ( InitError error, _ ) ->
            ( state, Cmd.none )

        ( InitOk model, _ ) ->
            updateInternal msg model
                |> Tuple.mapFirst InitOk

        _ ->
            ( state, Cmd.none )


updateInternal : Msg -> Model -> ( Model, Cmd Msg )
updateInternal msg model =
    case msg of
        InitReceived _ ->
            ( model, Cmd.none )

        AnimationFrameStarted deltaTimeMillis ->
            let
                deltaTime =
                    min (deltaTimeMillis / 1000) (1.0 / 30.0)
            in
            ( { model
                | ecs = Systems.update model.keys deltaTime model.ecs
                , deltaTime = deltaTime
                , stepCount = model.stepCount + 1
              }
            , Cmd.none
            )

        WindowSizeChanged width height ->
            ( { model
                | screen =
                    { width = width
                    , height = height
                    }
              }
            , Cmd.none
            )

        KeyChanged keyChange ->
            ( { model | keys = KeyControls.updateKeys keyChange model.keys }
            , Cmd.none
            )

        KeyReleased keyCode ->
            if keyCode == KeyCode.esc then
                ( { model | running = not model.running }
                , Cmd.none
                )

            else
                ( model, Cmd.none )



-- SUBSCRIPTIONS --


subscriptions : InitState -> Sub Msg
subscriptions state =
    case state of
        InitOk model ->
            if model.running then
                Sub.batch
                    [ onAnimationFrameDelta AnimationFrameStarted
                    , onResize WindowSizeChanged
                    , onKeyUp (Decode.map KeyChanged keyUpDecoder)
                    , onKeyDown (Decode.map KeyChanged keyDownDecoder)
                    , keyUpSubscription
                    ]

            else
                keyUpSubscription

        _ ->
            Sub.none


keyUpSubscription : Sub Msg
keyUpSubscription =
    onKeyUp (Decode.map KeyReleased Html.Events.keyCode)



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
    [ div
        [ style "color" "#fff"
        , style "position" "absolute"
        , style "top" "0"
        , style "bottom" "0"
        , style "left" "0"
        , style "right" "0"
        , style "overflow" "hidden"
        ]
        [ text <|
            "stepCount: "
                ++ String.fromInt model.stepCount
                ++ " ( "
                ++ String.fromFloat model.deltaTime
                ++ ")"
        , text <|
            if model.running then
                " running"

            else
                " paused"
        , div
            [ style "position" "absolute"
            , style "top" "0"
            , style "left" "0"
            , style "z-index" "-1"
            ]
            [ Systems.view
                { width = model.screen.width
                , height = model.screen.height
                , world = getWorld model.assets model.screen
                , ecs = model.ecs
                }
            ]
        ]
    ]



-- MAIN --


main : Program () InitState Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

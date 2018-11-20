module State exposing
    ( Msg
    , OutMsg(..)
    , Screen
    , State
    , World
    , init
    , randomStep
    , subscriptions
    , update
    )

import Assets exposing (Assets)
import Browser.Dom exposing (Viewport, getViewport)
import Browser.Events
    exposing
        ( onKeyDown
        , onKeyUp
        , onResize
        )
import Data.KeyCode as KeyCode exposing (KeyCode)
import Html.Events
import Json.Decode as Decode exposing (Decoder)
import Random exposing (Generator, Seed)
import Set exposing (Set)
import Systems.Render.RenderElement exposing (RenderElement)
import WebGL.Texture exposing (Texture)



-- Model


type alias State =
    { assets : Assets
    , seed : Seed
    , activeKeys : Set KeyCode
    , screen : Screen
    , world : World
    , time : Float
    , deltaTime : Float
    , test : Bool
    , renderElements : List RenderElement
    }


type alias World =
    { width : Float
    , height : Float
    }


type alias Screen =
    { width : Int
    , height : Int
    }


init : Assets -> Seed -> { width : Int, height : Int } -> State
init assets seed screen =
    { assets = assets
    , seed = seed
    , activeKeys = Set.empty
    , screen = screen
    , world = screenToWorld screen
    , time = 0
    , deltaTime = 0
    , test = False
    , renderElements = []
    }


screenToWorld : Screen -> World
screenToWorld screen =
    { width = 2 * toFloat screen.width
    , height = 2 * toFloat screen.height
    }


maxDeltaTime : Float
maxDeltaTime =
    1.0 / 30.0



-- Update


type Msg
    = WindowSizeChanged Int Int
    | KeyDown KeyCode
    | KeyUp KeyCode


type OutMsg
    = NoOp
    | PauseToggled


update : Msg -> State -> ( State, OutMsg )
update msg state =
    case msg of
        WindowSizeChanged width height ->
            ( { state
                | screen =
                    { width = width
                    , height = height
                    }
              }
            , NoOp
            )

        KeyDown keyCode ->
            ( { state | activeKeys = Set.insert keyCode state.activeKeys }
            , NoOp
            )

        KeyUp keyCode ->
            ( { state
                | activeKeys = Set.remove keyCode state.activeKeys
                , test =
                    if keyCode == KeyCode.t then
                        not state.test

                    else
                        state.test
              }
            , if keyCode == KeyCode.esc then
                PauseToggled

              else
                NoOp
            )


randomStep : Generator a -> State -> ( a, State )
randomStep generator state =
    let
        ( value, seed ) =
            Random.step generator state.seed
    in
    ( value, { state | seed = seed } )



-- Subscriptions


subscriptions : State -> Sub Msg
subscriptions state =
    Sub.batch
        [ onResize WindowSizeChanged
        , onKeyUp keyUpDecoder
        , onKeyDown keyDownDecoder
        ]


keyUpDecoder : Decoder Msg
keyUpDecoder =
    Decode.map KeyUp Html.Events.keyCode


keyDownDecoder : Decoder Msg
keyDownDecoder =
    Decode.map KeyDown Html.Events.keyCode

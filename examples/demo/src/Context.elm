module Context exposing
    ( Context
    , Msg
    , OutMsg(..)
    , Screen
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
import WebGL.Texture exposing (Texture)



-- Model


type alias Context =
    { assets : Assets
    , seed : Seed
    , activeKeys : Set KeyCode
    , screen : Screen
    , world : World
    , time : Float
    , deltaTime : Float
    , test : Bool
    }


type alias World =
    { width : Float
    , height : Float
    }


type alias Screen =
    { width : Int
    , height : Int
    }


init : Assets -> Seed -> { width : Int, height : Int } -> Context
init assets seed screen =
    { assets = assets
    , seed = seed
    , activeKeys = Set.empty
    , screen = screen
    , world = getWorld screen
    , time = 0
    , deltaTime = 0
    , test = False
    }


getWorld : Screen -> World
getWorld screen =
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


update : Msg -> Context -> ( Context, OutMsg )
update msg context =
    case msg of
        WindowSizeChanged width height ->
            ( { context
                | screen =
                    { width = width
                    , height = height
                    }
              }
            , NoOp
            )

        KeyDown keyCode ->
            ( { context | activeKeys = Set.insert keyCode context.activeKeys }
            , NoOp
            )

        KeyUp keyCode ->
            ( { context
                | activeKeys = Set.remove keyCode context.activeKeys
                , test =
                    if keyCode == KeyCode.t then
                        not context.test

                    else
                        context.test
              }
            , if keyCode == KeyCode.esc then
                PauseToggled

              else
                NoOp
            )


randomStep : Generator a -> Context -> ( a, Context )
randomStep generator context =
    let
        ( value, seed ) =
            Random.step generator context.seed
    in
    ( value, { context | seed = seed } )



-- Subscriptions


subscriptions : Context -> Sub Msg
subscriptions context =
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

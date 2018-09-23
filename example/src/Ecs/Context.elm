module Ecs.Context exposing
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
        ( onAnimationFrameDelta
        , onKeyDown
        , onKeyUp
        , onResize
        )
import Html.Events
import Json.Decode as Decode exposing (Decoder)
import KeyCode exposing (KeyCode)
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
    , stepCount : Int
    , running : Bool
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
    , stepCount = 0
    , running = True
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
    = AnimationFrameStarted Float
    | WindowSizeChanged Int Int
    | KeyDown KeyCode
    | KeyUp KeyCode


type OutMsg
    = None
    | DeltaTimeUpdated


update : Msg -> Context -> ( Context, OutMsg )
update msg context =
    case msg of
        AnimationFrameStarted deltaTimeMillis ->
            let
                deltaTime =
                    min (deltaTimeMillis / 1000) maxDeltaTime
            in
            ( { context
                | time = context.time + deltaTime
                , deltaTime = deltaTime
                , stepCount = context.stepCount + 1
              }
            , DeltaTimeUpdated
            )

        WindowSizeChanged width height ->
            ( { context
                | screen =
                    { width = width
                    , height = height
                    }
              }
            , None
            )

        KeyDown keyCode ->
            ( { context | activeKeys = Set.insert keyCode context.activeKeys }
            , None
            )

        KeyUp keyCode ->
            ( { context
                | activeKeys = Set.remove keyCode context.activeKeys
                , running =
                    if keyCode == KeyCode.esc then
                        not context.running

                    else
                        context.running
              }
            , None
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
    if context.running then
        Sub.batch
            (onAnimationFrameDelta AnimationFrameStarted
                :: defaultSubscriptions
            )

    else
        Sub.batch defaultSubscriptions


defaultSubscriptions : List (Sub Msg)
defaultSubscriptions =
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

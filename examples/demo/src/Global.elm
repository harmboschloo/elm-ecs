module Global exposing
    ( Global
    , Msg
    , Screen
    , World
    , getActiveKeys
    , getAssets
    , getDeltaTime
    , getScreen
    , getSpawnRate
    , getTime
    , getWorld
    , init
    , isPaused
    , isTestEnabled
    , randomStep
    , setTiming
    , subscriptions
    , update
    )

import Assets exposing (Assets)
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



-- Model


type Global
    = Global Model


type alias Model =
    { assets : Assets
    , seed : Seed
    , activeKeys : Set KeyCode
    , running : Bool
    , screen : Screen
    , world : World
    , time : Float
    , deltaTime : Float
    , test : Bool
    , spawnRate : Float
    }


type alias World =
    { width : Float
    , height : Float
    }


type alias Screen =
    { width : Int
    , height : Int
    }


init : Assets -> Seed -> Screen -> Global
init assets seed screen =
    Global
        { assets = assets
        , seed = seed
        , activeKeys = Set.empty
        , running = True
        , screen = screen
        , world = screenToWorld screen
        , time = 0
        , deltaTime = 0
        , test = False
        , spawnRate = 5
        }


screenToWorld : Screen -> World
screenToWorld screen =
    { width = 2 * toFloat screen.width
    , height = 2 * toFloat screen.height
    }


getAssets : Global -> Assets
getAssets (Global model) =
    model.assets


getTime : Global -> Float
getTime (Global model) =
    model.time


getDeltaTime : Global -> Float
getDeltaTime (Global model) =
    model.deltaTime


getActiveKeys : Global -> Set KeyCode
getActiveKeys (Global model) =
    model.activeKeys


getScreen : Global -> Screen
getScreen (Global model) =
    model.screen


getWorld : Global -> World
getWorld (Global model) =
    model.world


getSpawnRate : Global -> Float
getSpawnRate (Global model) =
    model.spawnRate


isPaused : Global -> Bool
isPaused (Global model) =
    not model.running


isTestEnabled : Global -> Bool
isTestEnabled (Global model) =
    model.test


setTiming : { deltaTime : Float, accumulatedTime : Float } -> Global -> Global
setTiming data (Global model) =
    Global
        { model
            | deltaTime = data.deltaTime
            , time = data.accumulatedTime
        }



-- Update


type Msg
    = WindowSizeChanged Int Int
    | KeyDown KeyCode
    | KeyUp KeyCode


update : Msg -> Global -> Global
update msg global =
    case msg of
        WindowSizeChanged width height ->
            updateWindowSize { width = width, height = height } global

        KeyDown keyCode ->
            updateKeyDown keyCode global

        KeyUp keyCode ->
            updateKeyUp keyCode global


updateWindowSize : Screen -> Global -> Global
updateWindowSize screen (Global model) =
    Global { model | screen = screen }


updateKeyDown : KeyCode -> Global -> Global
updateKeyDown keyCode (Global model) =
    Global { model | activeKeys = Set.insert keyCode model.activeKeys }


updateKeyUp : KeyCode -> Global -> Global
updateKeyUp keyCode (Global model) =
    Global
        { model
            | activeKeys = Set.remove keyCode model.activeKeys
            , test = toggleKey KeyCode.t keyCode model.test
            , running = toggleKey KeyCode.esc keyCode model.running
            , spawnRate = nextSpawnRate KeyCode.s keyCode model.spawnRate
        }


toggleKey : KeyCode -> KeyCode -> Bool -> Bool
toggleKey keyCode keyCodePressed currentValue =
    if keyCode == keyCodePressed then
        not currentValue

    else
        currentValue


nextSpawnRate : KeyCode -> KeyCode -> Float -> Float
nextSpawnRate keyCode keyCodePressed currentValue =
    if keyCode == keyCodePressed then
        case round currentValue of
            5 ->
                50.0

            50 ->
                0.0

            _ ->
                5.0

    else
        currentValue


randomStep : Generator a -> Global -> ( a, Global )
randomStep generator (Global model) =
    let
        ( value, seed ) =
            Random.step generator model.seed
    in
    ( value, Global { model | seed = seed } )



-- Subscriptions


subscriptions : Global -> Sub Msg
subscriptions _ =
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

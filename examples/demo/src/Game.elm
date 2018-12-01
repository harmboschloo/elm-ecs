module Game exposing
    ( EntityId
    , Game
    , Msg
    , Screen
    , Selector
    , World
    , addEntity
    , componentCount
    , components
    , entityCount
    , get
    , getActiveKeys
    , getAssets
    , getDeltaTime
    , getScreen
    , getTime
    , getWorld
    , init
    , insert
    , isPaused
    , isTestEnabled
    , process
    , randomStep
    , remove
    , removeEntity
    , selectList
    , setTiming
    , subscriptions
    , update
    , updateMsg
    )

import Assets exposing (Assets)
import Browser.Events
    exposing
        ( onKeyDown
        , onKeyUp
        , onResize
        )
import Components
    exposing
        ( Ai
        , Collectable
        , Collector
        , KeyControlsMap
        , Motion
        , Position
        , Scale
        , ScaleAnimation
        , Sprite
        , Velocity
        )
import Components.Controls exposing (Controls)
import Components.Transforms exposing (Transforms)
import Data.KeyCode as KeyCode exposing (KeyCode)
import Ecs
import Ecs.Select
import Ecs.Spec
import Html.Events
import Json.Decode as Decode exposing (Decoder)
import Random exposing (Generator, Seed)
import Set exposing (Set)



-- Ecs


type alias EntityId =
    Int


type alias Ecs =
    Ecs.Spec.Model12 EntityId Ai Collectable Collector Controls KeyControlsMap Motion Position Scale ScaleAnimation Sprite Transforms Velocity


type alias ComponentSpec a =
    Ecs.Spec.ComponentSpec EntityId Ecs a


type alias ComponentSpecs =
    { ai : ComponentSpec Ai
    , collectable : ComponentSpec Collectable
    , collector : ComponentSpec Collector
    , controls : ComponentSpec Controls
    , keyControlsMap : ComponentSpec KeyControlsMap
    , motion : ComponentSpec Motion
    , position : ComponentSpec Position
    , scale : ComponentSpec Scale
    , scaleAnimation : ComponentSpec ScaleAnimation
    , sprite : ComponentSpec Sprite
    , transforms : ComponentSpec Transforms
    , velocity : ComponentSpec Velocity
    }


type alias Selector a =
    Ecs.Select.Selector EntityId Ecs a


ecsSpec : Ecs.Spec.EcsSpec EntityId Ecs
ecsSpec =
    Ecs.Spec.ecs12


components : ComponentSpecs
components =
    Ecs.Spec.components12 ComponentSpecs


addEntity : Game -> ( EntityId, Game )
addEntity (Game global nextId ecs) =
    ( nextId
    , Game
        { global | entityCount = global.entityCount + 1 }
        (nextId + 1)
        ecs
    )


removeEntity : EntityId -> Game -> Game
removeEntity entityId (Game global nextId ecs) =
    Game
        { global | entityCount = global.entityCount - 1 }
        nextId
        (Ecs.clear ecsSpec entityId ecs)


entityCount : Game -> Int
entityCount (Game global _ _) =
    -- Ecs.entityCount ecsSpec ecs
    global.entityCount


componentCount : Game -> Int
componentCount (Game _ _ ecs) =
    Ecs.componentCount ecsSpec ecs


get : ComponentSpec a -> EntityId -> Game -> Maybe a
get spec entityId (Game _ _ ecs) =
    Ecs.get spec entityId ecs


insert : ComponentSpec a -> EntityId -> a -> Game -> Game
insert spec entityId data (Game global nextId ecs) =
    Game global nextId (Ecs.insert spec entityId data ecs)


update : ComponentSpec a -> EntityId -> (Maybe a -> Maybe a) -> Game -> Game
update spec entityId fn (Game global nextId ecs) =
    Game global nextId (Ecs.update spec entityId fn ecs)


remove : ComponentSpec a -> EntityId -> Game -> Game
remove spec entityId (Game global nextId ecs) =
    Game global nextId (Ecs.remove spec entityId ecs)


selectList : Selector a -> Game -> List ( EntityId, a )
selectList selector (Game global nextId ecs) =
    Ecs.selectList selector ecs


process : Selector a -> (( EntityId, a ) -> Game -> Game) -> Game -> Game
process selector fn game =
    List.foldl fn game (selectList selector game)



-- Model


type Game
    = Game Global EntityId Ecs


type alias Global =
    { assets : Assets
    , seed : Seed
    , activeKeys : Set KeyCode
    , running : Bool
    , screen : Screen
    , world : World
    , time : Float
    , deltaTime : Float
    , test : Bool
    , entityCount : Int
    }


type alias World =
    { width : Float
    , height : Float
    }


type alias Screen =
    { width : Int
    , height : Int
    }


init : Assets -> Seed -> Screen -> Game
init assets seed screen =
    Game
        { assets = assets
        , seed = seed
        , activeKeys = Set.empty
        , running = True
        , screen = screen
        , world = screenToWorld screen
        , time = 0
        , deltaTime = 0
        , test = False
        , entityCount = 0
        }
        0
        (Ecs.empty ecsSpec)


screenToWorld : Screen -> World
screenToWorld screen =
    { width = 2 * toFloat screen.width
    , height = 2 * toFloat screen.height
    }


getAssets : Game -> Assets
getAssets (Game global _ _) =
    global.assets


getTime : Game -> Float
getTime (Game global _ _) =
    global.time


getDeltaTime : Game -> Float
getDeltaTime (Game global _ _) =
    global.deltaTime


getActiveKeys : Game -> Set KeyCode
getActiveKeys (Game global _ _) =
    global.activeKeys


getScreen : Game -> Screen
getScreen (Game global _ _) =
    global.screen


getWorld : Game -> World
getWorld (Game global _ _) =
    global.world


isPaused : Game -> Bool
isPaused (Game global _ _) =
    not global.running


isTestEnabled : Game -> Bool
isTestEnabled (Game global _ _) =
    global.test


setTiming : { deltaTime : Float, accumulatedTime : Float } -> Game -> Game
setTiming data (Game global nextId ecs) =
    Game
        { global
            | deltaTime = data.deltaTime
            , time = data.accumulatedTime
        }
        nextId
        ecs



-- Update


type Msg
    = WindowSizeChanged Int Int
    | KeyDown KeyCode
    | KeyUp KeyCode


updateMsg : Msg -> Game -> Game
updateMsg msg game =
    case msg of
        WindowSizeChanged width height ->
            updateWindowSize { width = width, height = height } game

        KeyDown keyCode ->
            updateKeyDown keyCode game

        KeyUp keyCode ->
            updateKeyUp keyCode game


updateWindowSize : Screen -> Game -> Game
updateWindowSize screen (Game global nextId ecs) =
    Game { global | screen = screen } nextId ecs


updateKeyDown : KeyCode -> Game -> Game
updateKeyDown keyCode (Game global nextId ecs) =
    Game { global | activeKeys = Set.insert keyCode global.activeKeys } nextId ecs


updateKeyUp : KeyCode -> Game -> Game
updateKeyUp keyCode (Game global nextId ecs) =
    Game
        { global
            | activeKeys = Set.remove keyCode global.activeKeys
            , test = toggleKey KeyCode.t keyCode global.test
            , running = toggleKey KeyCode.esc keyCode global.running
        }
        nextId
        ecs


toggleKey : KeyCode -> KeyCode -> Bool -> Bool
toggleKey keyCode keyCodePressed currentValue =
    if keyCode == keyCodePressed then
        not currentValue

    else
        currentValue


randomStep : Generator a -> Game -> ( a, Game )
randomStep generator (Game global nextId ecs) =
    let
        ( value, seed ) =
            Random.step generator global.seed
    in
    ( value, Game { global | seed = seed } nextId ecs )



-- Subscriptions


subscriptions : Game -> Sub Msg
subscriptions global =
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

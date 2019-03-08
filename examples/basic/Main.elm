module Main exposing (main)

import Browser
import Browser.Events
import Ecs
import Ecs.Components4
import Ecs.EntityComponents
import Ecs.Singletons4
import Html
import Html.Attributes



-- ENTITY ID --


type alias EntityId =
    Int



-- COMPONENTS --


type alias Position =
    { x : Float, y : Float }


type alias Velocity =
    { x : Float, y : Float }


type OutOfBoundsResolution
    = Teleport
    | Destroy


type Display
    = Circle { radius : Float, color : String }
    | Image
        { src : String
        , width : Int
        , height : Int
        }


type alias Components =
    Ecs.Components4.Components4 EntityId Position Velocity OutOfBoundsResolution Display


type alias MultiComponentSpec =
    Ecs.MultiComponentSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


type alias ComponentSpecs =
    { all : MultiComponentSpec
    , position : ComponentSpec Position
    , velocity : ComponentSpec Velocity
    , outOfBoundsResolution : ComponentSpec OutOfBoundsResolution
    , display : ComponentSpec Display
    }


componentSpecs : ComponentSpecs
componentSpecs =
    Ecs.Components4.specs ComponentSpecs



-- SINGLETONS --


type alias Config =
    { worldWidth : Int
    , worldHeight : Int
    }


type alias Frame =
    { deltaTime : Float
    , count : Int
    }


type alias FpsStats =
    { timeSum : Float
    , frameCount : Int
    , fps : Float
    }


type alias Singletons =
    Ecs.Singletons4.Singletons4 Config EntityId Frame FpsStats


type alias SingletonSpec a =
    Ecs.SingletonSpec a Singletons


type alias SingletonSpecs =
    { config : SingletonSpec Config
    , lastEntityId : SingletonSpec EntityId
    , frame : SingletonSpec Frame
    , fpsStats : SingletonSpec FpsStats
    }


singletonSpecs : SingletonSpecs
singletonSpecs =
    Ecs.Singletons4.specs SingletonSpecs


initSingletons : Singletons
initSingletons =
    Ecs.Singletons4.init
        { worldWidth = 600
        , worldHeight = 600
        }
        -1
        { deltaTime = 0
        , count = 0
        }
        { timeSum = 0
        , frameCount = 0
        , fps = 0
        }


newEntityId : World -> ( World, EntityId )
newEntityId world =
    Ecs.updateSingletonAndReturn
        singletonSpecs.lastEntityId
        (\id -> id + 1)
        world



-- WORLD --


type alias World =
    Ecs.World EntityId Components Singletons


createWorld : World
createWorld =
    Ecs.emptyWorld componentSpecs.all initSingletons



--  SPAWN SYSTEM --


spawnEntities : World -> World
spawnEntities world =
    let
        config =
            Ecs.getSingleton singletonSpecs.config world

        frame =
            Ecs.getSingleton singletonSpecs.frame world

        position =
            { x = remainderBy config.worldWidth frame.count |> toFloat
            , y = remainderBy config.worldHeight (frame.count * 5) |> toFloat
            }

        display =
            if remainderBy 6 frame.count == 0 then
                Image
                    { src = "./h.png"
                    , width = 16
                    , height = 16
                    }

            else
                Circle
                    { radius = 5
                    , color = getColor frame.count
                    }
    in
    if remainderBy 10 frame.count == 0 then
        world
            |> newEntityId
            |> Ecs.andInsertEntity
            |> Ecs.andInsertComponent componentSpecs.position position
            |> Ecs.andInsertComponent componentSpecs.display display
            |> Tuple.first

    else
        let
            velocity =
                { x = (remainderBy 5 frame.count - 2) * 75 |> toFloat
                , y = (remainderBy 7 frame.count - 3) * 50 |> toFloat
                }

            outOfBoundsResolution =
                if remainderBy 4 frame.count == 0 then
                    Destroy

                else
                    Teleport
        in
        world
            |> newEntityId
            |> Ecs.andInsertEntity
            |> Ecs.andInsertComponent componentSpecs.position position
            |> Ecs.andInsertComponent componentSpecs.velocity velocity
            |> Ecs.andInsertComponent
                componentSpecs.outOfBoundsResolution
                outOfBoundsResolution
            |> Ecs.andInsertComponent componentSpecs.display display
            |> Tuple.first


getColor : Int -> String
getColor i =
    colors
        |> List.drop (remainderBy (List.length colors) i)
        |> List.head
        |> Maybe.withDefault "#f00"


colors : List String
colors =
    [ "#f00"
    , "#0f0"
    , "#00f"
    , "#ff0"
    , "#f0f"
    , "#0ff"
    , "#fff"
    , "#fa0"
    , "#000"
    ]



-- MOVEMENT SYSTEM --


moveEntities : World -> World
moveEntities world =
    let
        frame =
            Ecs.getSingleton singletonSpecs.frame world
    in
    Ecs.EntityComponents.foldFromFront2
        componentSpecs.position
        componentSpecs.velocity
        (moveEntity frame.deltaTime)
        world
        world


moveEntity : Float -> EntityId -> Position -> Velocity -> World -> World
moveEntity deltaTime entityId position velocity world =
    Ecs.insertComponent componentSpecs.position
        entityId
        { x = position.x + velocity.x * deltaTime
        , y = position.y + velocity.y * deltaTime
        }
        world



-- BOUNDS CHECK SYSTEM --


boundsCheckEntities : World -> World
boundsCheckEntities world =
    let
        config =
            Ecs.getSingleton singletonSpecs.config world
    in
    Ecs.EntityComponents.foldFromFront2
        componentSpecs.position
        componentSpecs.outOfBoundsResolution
        (boundsCheckEntity
            (toFloat config.worldWidth)
            (toFloat config.worldHeight)
        )
        world
        world


boundsCheckEntity :
    Float
    -> Float
    -> EntityId
    -> Position
    -> OutOfBoundsResolution
    -> World
    -> World
boundsCheckEntity worldWidth worldHeight entityId position resolution world =
    if
        (position.x < 0 || (position.x > worldWidth))
            || (position.y < 0 || (position.y > worldHeight))
    then
        case resolution of
            Teleport ->
                let
                    x =
                        if position.x < 0 then
                            worldWidth

                        else if position.x > worldWidth then
                            0

                        else
                            position.x

                    y =
                        if position.y < 0 then
                            worldHeight

                        else if position.y > worldHeight then
                            0

                        else
                            position.y
                in
                Ecs.insertComponent
                    componentSpecs.position
                    entityId
                    { x = x, y = y }
                    world

            Destroy ->
                Ecs.removeEntity componentSpecs.all entityId world

    else
        world



-- RENDER SYSTEM --


render : World -> List (Html.Html msg)
render world =
    let
        config =
            Ecs.getSingleton singletonSpecs.config world

        fpsStats =
            Ecs.getSingleton singletonSpecs.fpsStats world
    in
    [ Html.div
        [ Html.Attributes.style "position" "relative"
        , Html.Attributes.style "display" "inline-block"
        , Html.Attributes.style "width"
            (String.fromInt config.worldWidth ++ "px")
        , Html.Attributes.style "height"
            (String.fromInt config.worldHeight ++ "px")
        , Html.Attributes.style "background-color" "#aaa"
        ]
        (Ecs.EntityComponents.foldFromBack2
            componentSpecs.position
            componentSpecs.display
            (\_ position display list -> renderEntity position display :: list)
            []
            world
        )
    , Html.div []
        [ Html.text
            ("entities: "
                ++ (Ecs.worldEntityCount world |> String.fromInt)
            )
        , Html.text " - "
        , Html.text
            ("components: "
                ++ (Ecs.worldComponentCount componentSpecs.all world
                        |> String.fromInt
                   )
            )
        , Html.text " - "
        , Html.text ("fps: " ++ (round fpsStats.fps |> String.fromInt))
        ]
    ]


renderEntity : Position -> Display -> Html.Html msg
renderEntity position display =
    case display of
        Circle { radius, color } ->
            Html.div
                [ Html.Attributes.style "position" "absolute"
                , Html.Attributes.style "display" "inline-block"
                , Html.Attributes.style "left" (px (position.x - radius))
                , Html.Attributes.style "top" (px (position.y - radius))
                , Html.Attributes.style "width" (px (2 * radius))
                , Html.Attributes.style "height" (px (2 * radius))
                , Html.Attributes.style "background-color" color
                , Html.Attributes.style "border-radius" "50%"
                ]
                []

        Image { src, width, height } ->
            Html.img
                [ Html.Attributes.style "position" "absolute"
                , Html.Attributes.style "display" "inline-block"
                , Html.Attributes.style "left"
                    (px (position.x - (toFloat width / 2)))
                , Html.Attributes.style "top"
                    (px (position.y - (toFloat height / 2)))
                , Html.Attributes.src src
                , Html.Attributes.width width
                , Html.Attributes.height height
                ]
                []


px : Float -> String
px value =
    String.fromInt (round value) ++ "px"



-- FRAME SYSTEM --


updateFrame : Float -> World -> World
updateFrame deltaTimeMillis world =
    Ecs.updateSingleton singletonSpecs.frame
        (\frame ->
            { count = frame.count + 1
            , deltaTime = deltaTimeMillis / 1000
            }
        )
        world



-- FPS STATS SYSTEM --


updateFpsStats : World -> World
updateFpsStats world =
    let
        frame =
            Ecs.getSingleton singletonSpecs.frame world
    in
    Ecs.updateSingleton
        singletonSpecs.fpsStats
        (updateFpsStatsHelp frame.deltaTime)
        world


updateFpsStatsHelp : Float -> FpsStats -> FpsStats
updateFpsStatsHelp deltaTime stats =
    let
        timeSum =
            stats.timeSum + deltaTime

        frameCount =
            stats.frameCount + 1
    in
    if timeSum >= 1 then
        { timeSum = 0
        , frameCount = 0
        , fps = toFloat frameCount / timeSum
        }

    else
        { timeSum = timeSum
        , frameCount = frameCount
        , fps = stats.fps
        }



-- PROGRAM --


type Msg
    = OnAnimationFrameDelta Float


init : () -> ( World, Cmd Msg )
init _ =
    ( createWorld, Cmd.none )


update : Msg -> World -> ( World, Cmd Msg )
update msg world =
    case msg of
        OnAnimationFrameDelta deltaTimeMillis ->
            ( world
                |> updateFrame deltaTimeMillis
                |> updateFpsStats
                |> spawnEntities
                |> moveEntities
                |> boundsCheckEntities
            , Cmd.none
            )


subscriptions : World -> Sub Msg
subscriptions _ =
    Browser.Events.onAnimationFrameDelta OnAnimationFrameDelta


view : World -> Browser.Document Msg
view world =
    { title = "Ecs Basic Example"
    , body = render world
    }


main : Program () World Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

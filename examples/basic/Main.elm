module Main exposing (main)

import Array exposing (Array)
import Browser
import Browser.Events
import Ecs
import Ecs.Components
import Ecs.Select
import Ecs.Singletons
import Html
import Html.Attributes



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
    Ecs.Components.Components4 Position Velocity OutOfBoundsResolution Display


type alias AllComponentsSpec =
    Ecs.Components.AllComponentsSpec Components


type alias ComponentSpec a =
    Ecs.Components.ComponentSpec Components a


type alias ComponentSpecs =
    { all : AllComponentsSpec
    , position : ComponentSpec Position
    , velocity : ComponentSpec Velocity
    , outOfBoundsResolution : ComponentSpec OutOfBoundsResolution
    , display : ComponentSpec Display
    }


componentSpecs : ComponentSpecs
componentSpecs =
    Ecs.Components.specs4 ComponentSpecs



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
    Ecs.Singletons.Singletons3 Config Frame FpsStats


type alias SingletonSpec a =
    Ecs.Singletons.SingletonSpec Singletons a


type alias SingletonSpecs =
    { config : SingletonSpec Config
    , frame : SingletonSpec Frame
    , fpsStats : SingletonSpec FpsStats
    }


singletonSpecs : SingletonSpecs
singletonSpecs =
    Ecs.Singletons.specs3 SingletonSpecs


initSingletons : Singletons
initSingletons =
    Ecs.Singletons.init3
        { worldWidth = 600
        , worldHeight = 600
        }
        { deltaTime = 0
        , count = 0
        }
        { timeSum = 0
        , frameCount = 0
        , fps = 0
        }



-- WORLD --


type alias World =
    Ecs.World Components Singletons


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
            |> Ecs.createEntity
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
            |> Ecs.createEntity
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


type alias Move =
    { position : Position
    , velocity : Velocity
    }


moveSelector : Ecs.Select.Selector Components Move
moveSelector =
    Ecs.Select.select2 Move
        componentSpecs.position
        componentSpecs.velocity


moveEntities : World -> World
moveEntities world =
    let
        frame =
            Ecs.getSingleton singletonSpecs.frame world
    in
    Ecs.processAll moveSelector (moveEntity frame.deltaTime) world


moveEntity : Float -> ( Ecs.EntityId, Move ) -> World -> World
moveEntity deltaTime ( id, { position, velocity } ) world =
    Ecs.insertComponent componentSpecs.position
        id
        { x = position.x + velocity.x * deltaTime
        , y = position.y + velocity.y * deltaTime
        }
        world



-- BOUNDS CHECK SYSTEM --


type alias BoundsCheck =
    { position : Position
    , resolution : OutOfBoundsResolution
    }


boundsCheckSelector : Ecs.Select.Selector Components BoundsCheck
boundsCheckSelector =
    Ecs.Select.select2 BoundsCheck
        componentSpecs.position
        componentSpecs.outOfBoundsResolution


boundsCheckEntities : World -> World
boundsCheckEntities world =
    let
        config =
            Ecs.getSingleton singletonSpecs.config world
    in
    Ecs.processAll
        boundsCheckSelector
        (boundsCheckEntity
            (toFloat config.worldWidth)
            (toFloat config.worldHeight)
        )
        world


boundsCheckEntity :
    Float
    -> Float
    -> ( Ecs.EntityId, BoundsCheck )
    -> World
    -> World
boundsCheckEntity worldWidth worldHeight ( id, { position, resolution } ) world =
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
                    id
                    { x = x, y = y }
                    world

            Destroy ->
                Ecs.destroyEntity componentSpecs.all id world

    else
        world



-- RENDER SYSTEM --


type alias Render =
    { position : Position
    , display : Display
    }


renderSelector : Ecs.Select.Selector Components Render
renderSelector =
    Ecs.Select.select2 Render
        componentSpecs.position
        componentSpecs.display


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
        (world
            |> Ecs.selectAll renderSelector
            |> List.map renderEntity
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


renderEntity : ( Ecs.EntityId, Render ) -> Html.Html msg
renderEntity ( _, { position, display } ) =
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

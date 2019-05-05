module Main exposing (main)

import Browser
import Browser.Events
import Ecs
import Ecs.Components4
import Ecs.EntityComponents
import Ecs.Singletons2
import Html exposing (Html)
import Html.Attributes



-- COMPONENTS --


type alias Components =
    Ecs.Components4.Components4 EntityId Position Velocity Shape SpawnConfig


type alias EntityId =
    Int


type alias Position =
    { x : Float
    , y : Float
    }


type alias Velocity =
    { velocityX : Float
    , velocityY : Float
    }


type alias Shape =
    { width : Float
    , height : Float
    , color : String
    }


type alias SpawnConfig =
    { frameInterval : Int
    , velocity : Velocity
    , shape : Shape
    }



-- SINGLETONS --


type alias Singletons =
    Ecs.Singletons2.Singletons2 EntityId Int



-- SPECS --


type alias Specs =
    { allComponents : AllComponentsSpec
    , position : ComponentSpec Position
    , velocity : ComponentSpec Velocity
    , shape : ComponentSpec Shape
    , spawnConfig : ComponentSpec SpawnConfig
    , nextEntityId : SingletonSpec EntityId
    , frameCount : SingletonSpec Int
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


type alias SingletonSpec a =
    Ecs.SingletonSpec a Singletons


specs : Specs
specs =
    Specs |> Ecs.Components4.specs |> Ecs.Singletons2.specs



-- INIT --


type alias World =
    Ecs.World EntityId Components Singletons


emptyWorld : World
emptyWorld =
    Ecs.emptyWorld specs.allComponents (Ecs.Singletons2.init 0 0)


initEntities : World -> World
initEntities world =
    world
        -- entity id 0, static red shape
        |> newEntity
        |> Ecs.insertComponent specs.position
            { x = 20
            , y = 20
            }
        |> Ecs.insertComponent specs.shape
            { width = 20
            , height = 15
            , color = "red"
            }
        -- entity id 1, spawner for moving green shapes
        |> newEntity
        |> Ecs.insertComponent specs.position
            { x = 30
            , y = 75
            }
        |> Ecs.insertComponent specs.spawnConfig
            { frameInterval = 120
            , velocity =
                { velocityX = 4
                , velocityY = -1
                }
            , shape =
                { width = 15
                , height = 20
                , color = "green"
                }
            }
        -- entity id 2, spawner for moving blue shapes
        |> newEntity
        |> Ecs.insertComponent specs.position
            { x = 70
            , y = 30
            }
        |> Ecs.insertComponent specs.spawnConfig
            { frameInterval = 60
            , velocity =
                { velocityX = -5
                , velocityY = -5
                }
            , shape =
                { width = 15
                , height = 15
                , color = "blue"
                }
            }


init : () -> ( World, Cmd Msg )
init _ =
    ( initEntities emptyWorld, Cmd.none )



-- UPDATE --


type Msg
    = GotAnimationFrameDeltaMilliseconds Float


update : Msg -> World -> ( World, Cmd Msg )
update msg world =
    case msg of
        GotAnimationFrameDeltaMilliseconds deltaMilliseconds ->
            ( world
                |> updateFrameCount
                |> spawnEntities
                |> updatePositions (deltaMilliseconds / 1000)
                |> checkBounds
            , Cmd.none
            )


newEntity : World -> World
newEntity world =
    world
        |> Ecs.insertEntity (Ecs.getSingleton specs.nextEntityId world)
        |> Ecs.updateSingleton specs.nextEntityId (\id -> id + 1)


updateFrameCount : World -> World
updateFrameCount world =
    Ecs.updateSingleton specs.frameCount (\frameCount -> frameCount + 1) world


spawnEntities : World -> World
spawnEntities world =
    Ecs.EntityComponents.processFromLeft2
        specs.spawnConfig
        specs.position
        spawnEntity
        world


spawnEntity : EntityId -> SpawnConfig -> Position -> World -> World
spawnEntity _ config position world =
    let
        frameCount =
            Ecs.getSingleton specs.frameCount world
    in
    if remainderBy config.frameInterval frameCount == 0 then
        world
            |> newEntity
            |> Ecs.insertComponent specs.position position
            |> Ecs.insertComponent specs.velocity config.velocity
            |> Ecs.insertComponent specs.shape config.shape

    else
        world


updatePositions : Float -> World -> World
updatePositions deltaSeconds world =
    Ecs.EntityComponents.processFromLeft2
        specs.velocity
        specs.position
        (updateEntityPosition deltaSeconds)
        world


updateEntityPosition : Float -> EntityId -> Velocity -> Position -> World -> World
updateEntityPosition deltaSeconds _ velocity position world =
    Ecs.insertComponent specs.position
        { x = position.x + velocity.velocityX * deltaSeconds
        , y = position.y + velocity.velocityY * deltaSeconds
        }
        world


checkBounds : World -> World
checkBounds world =
    Ecs.EntityComponents.processFromLeft3
        specs.shape
        specs.velocity
        specs.position
        checkEntityBounds
        world


checkEntityBounds : EntityId -> Shape -> Velocity -> Position -> World -> World
checkEntityBounds _ shape _ position world =
    if
        (position.x < 0 || (position.x + shape.width) > 100)
            || (position.y < 0 || (position.y + shape.height) > 100)
    then
        Ecs.removeEntity specs.allComponents world

    else
        world



-- SUBSCRIPTIONS --


subscriptions : World -> Sub Msg
subscriptions _ =
    Browser.Events.onAnimationFrameDelta GotAnimationFrameDeltaMilliseconds



-- VIEW --


view : World -> Browser.Document Msg
view world =
    { title = "readme example 2 - elm-ecs"
    , body = [ Html.div worldAttributes (renderEntities world) ]
    }


worldAttributes : List (Html.Attribute Msg)
worldAttributes =
    [ Html.Attributes.style "position" "fixed"
    , Html.Attributes.style "top" "0"
    , Html.Attributes.style "right" "0"
    , Html.Attributes.style "bottom" "0"
    , Html.Attributes.style "left" "0"
    ]


renderEntities : World -> List (Html.Html Msg)
renderEntities world =
    Ecs.EntityComponents.foldFromRight2
        specs.shape
        specs.position
        addEntity
        []
        world


addEntity : EntityId -> Shape -> Position -> List (Html Msg) -> List (Html Msg)
addEntity entityId shape position elements =
    Html.div
        (entityAttributes shape position)
        [ Html.text (String.fromInt entityId) ]
        :: elements


entityAttributes : Shape -> Position -> List (Html.Attribute Msg)
entityAttributes shape position =
    [ Html.Attributes.style "position" "absolute"
    , Html.Attributes.style "left" (pct position.x)
    , Html.Attributes.style "top" (pct position.y)
    , Html.Attributes.style "width" (pct shape.width)
    , Html.Attributes.style "height" (pct shape.height)
    , Html.Attributes.style "background-color" shape.color
    , Html.Attributes.style "color" "white"
    , Html.Attributes.style "padding" "5px"
    ]


pct : Float -> String
pct value =
    String.fromFloat value ++ "%"



-- MAIN --


main : Program () World Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

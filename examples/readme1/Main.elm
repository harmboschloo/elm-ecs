module Main exposing (main)

import Browser
import Browser.Events
import Ecs
import Ecs.Components3
import Ecs.EntityComponents
import Html exposing (Html)
import Html.Attributes



-- COMPONENTS --


type alias Components =
    Ecs.Components3.Components3 EntityId Position Velocity Shape


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



-- SPECS --


type alias Specs =
    { all : AllComponentsSpec
    , position : ComponentSpec Position
    , velocity : ComponentSpec Velocity
    , shape : ComponentSpec Shape
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


specs : Specs
specs =
    Ecs.Components3.specs Specs



-- INIT --


type alias World =
    Ecs.World EntityId Components ()


emptyWorld : World
emptyWorld =
    Ecs.emptyWorld specs.all ()


initEntities : World -> World
initEntities world =
    world
        -- entity id 0, static red shape
        |> Ecs.insertEntity 0
        |> Ecs.insertComponent specs.position
            { x = 20
            , y = 20
            }
        |> Ecs.insertComponent specs.shape
            { width = 20
            , height = 15
            , color = "red"
            }
        -- entity id 1, moving green shape
        |> Ecs.insertEntity 1
        |> Ecs.insertComponent specs.position
            { x = 30
            , y = 75
            }
        |> Ecs.insertComponent specs.velocity
            { velocityX = 4
            , velocityY = -1
            }
        |> Ecs.insertComponent specs.shape
            { width = 15
            , height = 20
            , color = "green"
            }
        -- entity id 2, moving blue shape
        |> Ecs.insertEntity 2
        |> Ecs.insertComponent specs.position
            { x = 70
            , y = 30
            }
        |> Ecs.insertComponent specs.velocity
            { velocityX = -5
            , velocityY = -5
            }
        |> Ecs.insertComponent specs.shape
            { width = 15
            , height = 15
            , color = "blue"
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
                |> updatePositions (deltaMilliseconds / 1000)
                |> checkBounds
            , Cmd.none
            )


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
        Ecs.removeEntity specs.all world

    else
        world



-- SUBSCRIPTIONS --


subscriptions : World -> Sub Msg
subscriptions _ =
    Browser.Events.onAnimationFrameDelta GotAnimationFrameDeltaMilliseconds



-- VIEW --


view : World -> Browser.Document Msg
view world =
    { title = "readme example 1 - elm-ecs"
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

module Main exposing (main)

import Browser
import Browser.Events
import Ecs
import Ecs.Components3
import Ecs.EntityComponents
import Html
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
    { all : AllComponentSpec
    , position : ComponentSpec Position
    , velocity : ComponentSpec Velocity
    , shape : ComponentSpec Shape
    }


type alias AllComponentSpec =
    Ecs.AllComponentSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


specs : Specs
specs =
    Ecs.Components3.specs Specs



-- INIT --


type alias Model =
    World


type alias World =
    Ecs.World EntityId Components ()


init : () -> ( World, Cmd Msg )
init _ =
    ( initEntities emptyWorld, Cmd.none )


emptyWorld : World
emptyWorld =
    Ecs.emptyWorld specs.all ()


initEntities : World -> World
initEntities world =
    world
        -- static red shape, entity id 0
        |> Ecs.insertEntity 0
        |> Ecs.insertComponent specs.position 0 { x = 20, y = 20 }
        |> Ecs.insertComponent specs.shape 0 { width = 20, height = 15, color = "red" }
        -- moving green shape, entity id 1
        |> Ecs.insertEntity 1
        |> Ecs.insertComponent specs.position 1 { x = 30, y = 75 }
        |> Ecs.insertComponent specs.velocity 1 { velocityX = 4, velocityY = -1 }
        |> Ecs.insertComponent specs.shape 1 { width = 15, height = 20, color = "green" }
        -- moving blue shape, entity id 2
        |> Ecs.insertEntity 2
        |> Ecs.insertComponent specs.position 2 { x = 70, y = 30 }
        |> Ecs.insertComponent specs.velocity 2 { velocityX = -5, velocityY = -5 }
        |> Ecs.insertComponent specs.shape 2 { width = 15, height = 15, color = "blue" }



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
    Ecs.EntityComponents.foldl2
        specs.velocity
        specs.position
        (\entityId velocity position currentWorld ->
            Ecs.insertComponent specs.position
                entityId
                { x = position.x + velocity.velocityX * deltaSeconds
                , y = position.y + velocity.velocityY * deltaSeconds
                }
                currentWorld
        )
        world
        world


checkBounds : World -> World
checkBounds world =
    Ecs.EntityComponents.foldl2
        specs.position
        specs.shape
        (\entityId position shape currentWorld ->
            if
                (position.x < 0 || (position.x + shape.width) > 100)
                    || (position.y < 0 || (position.y + shape.height) > 100)
            then
                Ecs.removeEntity specs.all entityId currentWorld

            else
                currentWorld
        )
        world
        world



-- SUBSCRIPTIONS --


subscriptions : World -> Sub Msg
subscriptions _ =
    Browser.Events.onAnimationFrameDelta GotAnimationFrameDeltaMilliseconds



-- VIEW --


view : World -> Browser.Document Msg
view world =
    { title = "bounce - elm-ecs"
    , body =
        [ Html.div
            [ Html.Attributes.style "position" "fixed"
            , Html.Attributes.style "top" "0"
            , Html.Attributes.style "right" "0"
            , Html.Attributes.style "bottom" "0"
            , Html.Attributes.style "left" "0"
            ]
            (renderEntities world)
        ]
    }


renderEntities : World -> List (Html.Html Msg)
renderEntities world =
    Ecs.EntityComponents.foldr2
        specs.shape
        specs.position
        (\entityId shape position elements ->
            Html.div
                [ Html.Attributes.style "position" "absolute"
                , Html.Attributes.style "left" (pct position.x)
                , Html.Attributes.style "top" (pct position.y)
                , Html.Attributes.style "width" (pct shape.width)
                , Html.Attributes.style "height" (pct shape.height)
                , Html.Attributes.style "background-color" shape.color
                , Html.Attributes.style "color" "white"
                , Html.Attributes.style "padding" "5px"
                ]
                [ Html.text (String.fromInt entityId) ]
                :: elements
        )
        []
        world


pct : Float -> String
pct value =
    String.fromFloat value ++ "%"



-- MAIN --


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

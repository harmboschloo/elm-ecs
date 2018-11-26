module Main exposing (main)

import Browser
import Browser.Events
import Ecs.Api
import Ecs.Api4
import Ecs.Select
import Html
import Html.Attributes



--  COMPONENTS --


type alias Position =
    { x : Float, y : Float }


type alias Velocity =
    { x : Float, y : Float }


type OutOfBoundsResolution
    = Teleport
    | Destroy


type alias Color =
    String



-- ECS SETUP --


type alias EntityId =
    Int


type alias Ecs =
    Ecs.Api4.Ecs EntityId Position Velocity OutOfBoundsResolution Color


type alias ComponentTypes =
    { position : Ecs.Api.ComponentType EntityId Ecs Position
    , velocity : Ecs.Api.ComponentType EntityId Ecs Velocity
    , outOfBoundsResolution : Ecs.Api.ComponentType EntityId Ecs OutOfBoundsResolution
    , color : Ecs.Api.ComponentType EntityId Ecs Color
    }


type alias Selector a =
    Ecs.Select.Selector EntityId Ecs a


ecsType : Ecs.Api.EcsType EntityId Ecs
ecsType =
    Ecs.Api4.ecs


componentTypes : ComponentTypes
componentTypes =
    Ecs.Api4.components ComponentTypes



--  SPAWN SYSTEM --


spawnEntities : ( State, Ecs ) -> ( State, Ecs )
spawnEntities ( state, ecs ) =
    if remainderBy 10 state.frameCount == 0 then
        let
            n =
                state.frameCount // 10

            ( id, newState ) =
                nextId state

            newEcs =
                ecs
                    |> Ecs.Api.insert componentTypes.position
                        id
                        { x = remainderBy state.worldWidth state.frameCount |> toFloat
                        , y = remainderBy state.worldHeight state.frameCount |> toFloat
                        }
                    |> Ecs.Api.insert componentTypes.velocity
                        id
                        { x = (remainderBy 5 n - 2) * 75 |> toFloat
                        , y = (remainderBy 7 n - 3) * 50 |> toFloat
                        }
                    |> Ecs.Api.insert componentTypes.outOfBoundsResolution
                        id
                        (if remainderBy 2 n == 0 then
                            Teleport

                         else
                            Destroy
                        )
                    |> Ecs.Api.insert componentTypes.color
                        id
                        (colors
                            |> List.drop (remainderBy (List.length colors) n)
                            |> List.head
                            |> Maybe.withDefault "#f00"
                        )
        in
        ( newState, newEcs )

    else
        ( state, ecs )


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


moveSelector : Selector Move
moveSelector =
    Ecs.Select.select2 Move
        componentTypes.position
        componentTypes.velocity


moveEntities : ( State, Ecs ) -> ( State, Ecs )
moveEntities ( state, ecs ) =
    ( state
    , Ecs.Api.selectList moveSelector ecs
        |> List.foldl (moveEntity state.deltaTime) ecs
    )


moveEntity : Float -> ( EntityId, Move ) -> Ecs -> Ecs
moveEntity deltaTime ( id, { position, velocity } ) ecs =
    Ecs.Api.insert componentTypes.position
        id
        { x = position.x + velocity.x * deltaTime
        , y = position.y + velocity.y * deltaTime
        }
        ecs



-- BOUNDS CHECK SYSTEM --


type alias BoundsCheck =
    { position : Position
    , resolution : OutOfBoundsResolution
    }


boundsCheckSelector : Selector BoundsCheck
boundsCheckSelector =
    Ecs.Select.select2 BoundsCheck
        componentTypes.position
        componentTypes.outOfBoundsResolution


boundsCheckEntities : ( State, Ecs ) -> ( State, Ecs )
boundsCheckEntities ( state, ecs ) =
    ( state
    , Ecs.Api.selectList boundsCheckSelector ecs
        |> List.foldl
            (boundsCheckEntity
                (toFloat state.worldWidth)
                (toFloat state.worldHeight)
            )
            ecs
    )


boundsCheckEntity : Float -> Float -> ( EntityId, BoundsCheck ) -> Ecs -> Ecs
boundsCheckEntity worldWidth worldHeight ( id, { position, resolution } ) ecs =
    case resolution of
        Teleport ->
            let
                newX =
                    if position.x < 0 then
                        worldWidth

                    else if position.x > worldWidth then
                        0

                    else
                        position.x

                newY =
                    if position.y < 0 then
                        worldHeight

                    else if position.y > worldHeight then
                        0

                    else
                        position.y
            in
            if position.x /= newX || position.y /= newY then
                Ecs.Api.insert componentTypes.position
                    id
                    { x = newX, y = newY }
                    ecs

            else
                ecs

        Destroy ->
            if
                (position.x < 0)
                    || (position.x > worldWidth)
                    || (position.y < 0)
                    || (position.y > worldHeight)
            then
                Ecs.Api.clear ecsType id ecs

            else
                ecs



-- RENDER SYSTEM --


type alias Render =
    { position : Position
    , color : Color
    }


renderSelector : Selector Render
renderSelector =
    Ecs.Select.select2 Render
        componentTypes.position
        componentTypes.color


renderEntities : Ecs -> List (Html.Html msg)
renderEntities ecs =
    Ecs.Api.selectList renderSelector ecs
        |> List.map renderEntity


renderEntity : ( EntityId, Render ) -> Html.Html msg
renderEntity ( _, { position, color } ) =
    Html.div
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "display" "inline-block"
        , Html.Attributes.style "left"
            (String.fromInt (round position.x - 2) ++ "px")
        , Html.Attributes.style "top"
            (String.fromInt (round position.y - 2) ++ "px")
        , Html.Attributes.style "width" "4px"
        , Html.Attributes.style "height" "4px"
        , Html.Attributes.style "background-color" color
        ]
        []



-- MODEL --


type alias Model =
    ( State, Ecs )


type alias State =
    { nextId : EntityId
    , worldWidth : Int
    , worldHeight : Int
    , deltaTime : Float
    , frameCount : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( ( { nextId = 0
        , worldWidth = 300
        , worldHeight = 300
        , deltaTime = 0
        , frameCount = 0
        }
      , Ecs.Api.empty ecsType
      )
    , Cmd.none
    )


nextId : State -> ( EntityId, State )
nextId state =
    ( state.nextId, { state | nextId = state.nextId + 1 } )



-- UPDATE --


type Msg
    = OnAnimationFrameDelta Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ( state, ecs ) =
    case msg of
        OnAnimationFrameDelta deltaTimeMillis ->
            ( ( { state
                    | deltaTime = deltaTimeMillis / 1000
                    , frameCount = state.frameCount + 1
                }
              , ecs
              )
                |> spawnEntities
                |> moveEntities
                |> boundsCheckEntities
            , Cmd.none
            )



-- SUBSCRIPTIONS --


subscriptions : Model -> Sub Msg
subscriptions state =
    Browser.Events.onAnimationFrameDelta OnAnimationFrameDelta



-- VIEW --


view : Model -> Browser.Document Msg
view ( state, ecs ) =
    { title = "Ecs Basic Example"
    , body =
        [ Html.div
            [ Html.Attributes.style "position" "relative"
            , Html.Attributes.style "display" "inline-block"
            , Html.Attributes.style "width"
                (String.fromInt state.worldWidth ++ "px")
            , Html.Attributes.style "height"
                (String.fromInt state.worldHeight ++ "px")
            , Html.Attributes.style "background-color" "#aaa"
            ]
            (renderEntities ecs)
        , Html.div []
            [ Html.text ("entities: " ++ (Ecs.Api.entityCount ecsType ecs |> String.fromInt))
            , Html.text " - "
            , Html.text
                ("fps: " ++ (1 / state.deltaTime |> round |> String.fromInt))
            ]
        ]
    }



-- MAIN --


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

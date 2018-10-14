module EcsGenerator.Example.Systems exposing (checkBounds, move, render)

import EcsGenerator.Example.Components exposing (Color, Position)
import EcsGenerator.Example.Ecs as Ecs exposing (Ecs, EntityId)
import Html exposing (Html)
import Html.Attributes


worldWidth : Int
worldWidth =
    400


worldHeight : Int
worldHeight =
    300



-- Move --


move : ( Ecs, Float ) -> ( Ecs, Float )
move =
    Ecs.iterate Ecs.movementNode moveEntity


moveEntity : Ecs.EntityId -> Ecs.MovementNode -> ( Ecs, Float ) -> ( Ecs, Float )
moveEntity entityId { position, velocity } ( ecs, deltaTime ) =
    ( Ecs.insert
        entityId
        Ecs.positionComponent
        { x = position.x + velocity.x * deltaTime
        , y = position.y + velocity.y * deltaTime
        }
        ecs
    , deltaTime
    )



-- CHECK BOUNDS --


checkBounds : ( Ecs, Float ) -> ( Ecs, Float )
checkBounds =
    Ecs.iterate Ecs.boundsNode checkEntityBounds


checkEntityBounds : Ecs.EntityId -> Ecs.BoundsNode -> ( Ecs, Float ) -> ( Ecs, Float )
checkEntityBounds entityId { position } ( ecs, deltaTime ) =
    let
        newX =
            if position.x < 0 then
                toFloat worldWidth

            else if position.x > toFloat worldWidth then
                0

            else
                position.x

        newY =
            if position.y < 0 then
                toFloat worldHeight

            else if position.y > toFloat worldHeight then
                0

            else
                position.y
    in
    if position.x /= newX || position.y /= newY then
        ( Ecs.insert entityId Ecs.positionComponent { x = newX, y = newY } ecs
        , deltaTime
        )

    else
        ( ecs
        , deltaTime
        )



-- RENDER --


render : Ecs -> Html msg
render ecs =
    Html.div
        [ Html.Attributes.style "position" "relative"
        , Html.Attributes.style "display" "inline-block"
        , Html.Attributes.style "width" (String.fromInt worldWidth ++ "px")
        , Html.Attributes.style "height" (String.fromInt worldHeight ++ "px")
        , Html.Attributes.style "background-color" "#aaa"
        ]
        (( ecs, [] )
            |> Ecs.iterate Ecs.renderNode renderEntity
            |> Tuple.second
        )


renderEntity : Ecs.EntityId -> Ecs.RenderNode -> ( Ecs, List (Html msg) ) -> ( Ecs, List (Html msg) )
renderEntity entityId { position, color } ( ecs, elements ) =
    ( ecs
    , Html.div
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "display" "inline-block"
        , Html.Attributes.style "left" (String.fromInt (round position.x - 2) ++ "px")
        , Html.Attributes.style "top" (String.fromInt (round position.y - 2) ++ "px")
        , Html.Attributes.style "width" "4px"
        , Html.Attributes.style "height" "4px"
        , Html.Attributes.style "background-color" color
        ]
        []
        :: elements
    )

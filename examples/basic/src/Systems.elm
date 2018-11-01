module Systems exposing (checkBounce, checkTeleport, move, render)

import Components exposing (Color, Position)
import Ecs exposing (Ecs, EntityId)
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



--  BOUNDS CHECK --


checkBounce : ( Ecs, Float ) -> ( Ecs, Float )
checkBounce =
    Ecs.iterate Ecs.boundsBounceNode checkEntityBoundsBounce


checkEntityBoundsBounce :
    Ecs.EntityId
    -> Ecs.BoundsBounceNode
    -> ( Ecs, Float )
    -> ( Ecs, Float )
checkEntityBoundsBounce entityId { bounce, position, velocity } ( ecs, deltaTime ) =
    let
        absNewVelocityX =
            abs (velocity.x * bounce.damping)

        absNewVelocityY =
            abs (velocity.y * bounce.damping)

        ( newX, newVelocityX, changedX ) =
            if position.x < 0 then
                ( 0, absNewVelocityX, True )

            else if position.x > toFloat worldWidth then
                ( toFloat worldWidth, -absNewVelocityX, True )

            else
                ( position.x, velocity.x, False )

        ( newY, newVelocityY, changedY ) =
            if position.y < 0 then
                ( 0, absNewVelocityY, True )

            else if position.y > toFloat worldHeight then
                ( toFloat worldHeight, -absNewVelocityY, True )

            else
                ( position.y, velocity.y, False )
    in
    if changedX || changedY then
        ( ecs
            |> Ecs.insert entityId Ecs.positionComponent { x = newX, y = newY }
            |> Ecs.insert entityId Ecs.velocityComponent { x = newVelocityX, y = newVelocityY }
        , deltaTime
        )

    else
        ( ecs
        , deltaTime
        )


checkTeleport : ( Ecs, Float ) -> ( Ecs, Float )
checkTeleport =
    Ecs.iterate Ecs.boundsTeleportNode checkEntityBoundsTeleport


checkEntityBoundsTeleport :
    Ecs.EntityId
    -> Ecs.BoundsTeleportNode
    -> ( Ecs, Float )
    -> ( Ecs, Float )
checkEntityBoundsTeleport entityId { position } ( ecs, deltaTime ) =
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

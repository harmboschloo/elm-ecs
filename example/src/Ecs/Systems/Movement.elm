module Ecs.Systems.Movement exposing (update)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Position, Velocity)


update : Float -> Ecs -> Ecs
update deltaTime ecs =
    ( ecs, deltaTime )
        |> Ecs.processEntities2 Ecs.velocity Ecs.position updateEntity
        |> Tuple.first


updateEntity :
    EntityId
    -> Velocity
    -> Position
    -> ( Ecs, Float )
    -> ( Ecs, Float )
updateEntity entityId velocity position ( ecs, deltaTime ) =
    let
        newPosition =
            { x = position.x + velocity.velocityX * deltaTime
            , y = position.y + velocity.velocityY * deltaTime
            , angle = position.angle + velocity.angularVelocity * deltaTime
            }
    in
    ( Ecs.insertComponent Ecs.position newPosition entityId ecs, deltaTime )

module Ecs.Systems.Movement exposing (update)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Position, Velocity)
import Ecs.Context exposing (Context)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.processEntities2 Ecs.velocity Ecs.position updateEntity


updateEntity :
    EntityId
    -> Velocity
    -> Position
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateEntity entityId velocity position ( ecs, { deltaTime } as context ) =
    ( Ecs.insertComponent
        Ecs.position
        { x = position.x + velocity.velocityX * deltaTime
        , y = position.y + velocity.velocityY * deltaTime
        , angle = position.angle + velocity.angularVelocity * deltaTime
        }
        entityId
        ecs
    , context
    )

module Systems.Movement exposing (update)

import Components exposing (Position, Velocity)
import Context exposing (Context)
import Ecs exposing (Ecs, EntityId)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterateEntities2 Ecs.velocity Ecs.position updateEntity


updateEntity :
    EntityId
    -> Velocity
    -> Position
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateEntity entityId velocity position ( ecs, { deltaTime } as context ) =
    ( Ecs.insertComponent
        entityId
        Ecs.position
        { x = position.x + velocity.velocityX * deltaTime
        , y = position.y + velocity.velocityY * deltaTime
        , angle = position.angle + velocity.angularVelocity * deltaTime
        }
        ecs
    , context
    )

module Systems.Movement exposing (update)

import Components exposing (Position, Velocity)
import Context exposing (Context)
import Ecs exposing (Ecs)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterate2 Ecs.velocityComponent Ecs.positionComponent updateEntity


updateEntity :
    Ecs.EntityId
    -> Velocity
    -> Position
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateEntity entityId velocity position ( ecs, { deltaTime } as context ) =
    ( Ecs.insert
        entityId
        Ecs.positionComponent
        { x = position.x + velocity.velocityX * deltaTime
        , y = position.y + velocity.velocityY * deltaTime
        , angle = position.angle + velocity.angularVelocity * deltaTime
        }
        ecs
    , context
    )

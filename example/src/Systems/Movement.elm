module Systems.Movement exposing (update)

import Context exposing (Context)
import Ecs exposing (Ecs)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterateEntities Ecs.movementNode updateEntity


updateEntity :
    Ecs.EntityId
    -> Ecs.MovementNode
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateEntity entityId { position, velocity } ( ecs, { deltaTime } as context ) =
    ( Ecs.insertComponent
        entityId
        Ecs.positionComponent
        { x = position.x + velocity.velocityX * deltaTime
        , y = position.y + velocity.velocityY * deltaTime
        , angle = position.angle + velocity.angularVelocity * deltaTime
        }
        ecs
    , context
    )

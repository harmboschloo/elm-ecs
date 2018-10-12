module Systems.Collection exposing (update)

import Components exposing (Position, Velocity)
import Context exposing (Context)
import Data.Animation as Animation
import Ease
import Ecs exposing (Ecs)


type alias CollectableEntity =
    { id : Ecs.EntityId
    , position : Position
    }


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterateEntities Ecs.collectableNode checkCollectable


checkCollectable :
    Ecs.EntityId
    -> Ecs.CollectableNode
    -> ( Ecs, Context )
    -> ( Ecs, Context )
checkCollectable entityId node =
    Ecs.iterateEntities Ecs.collectorNode
        (checkCollection (CollectableEntity entityId node.position))


checkCollection :
    CollectableEntity
    -> Ecs.EntityId
    -> Ecs.CollectorNode
    -> ( Ecs, Context )
    -> ( Ecs, Context )
checkCollection collectable entityId { collector, position } ( ecs, context ) =
    let
        deltaX =
            collectable.position.x - position.x

        deltaY =
            collectable.position.y - position.y

        distanceSquared =
            deltaX * deltaX + deltaY * deltaY

        radiusSquared =
            collector.radius * collector.radius
    in
    if distanceSquared < radiusSquared then
        ( ecs
            |> Ecs.removeComponent collectable.id Ecs.collectableComponent
            |> Ecs.insertComponent
                collectable.id
                Ecs.velocityComponent
                (Velocity 0 0 (2 * pi))
            |> Ecs.insertComponent
                collectable.id
                Ecs.scaleAnimationComponent
                (Animation.animation
                    { startTime = context.time
                    , duration = 0.5
                    , from = 1
                    , to = 1.5
                    }
                    |> Animation.andNext
                        (Animation.nextAnimation
                            { duration = 0.5
                            , to = 0
                            }
                        )
                )
            |> Ecs.insertComponent
                collectable.id
                Ecs.destroyComponent
                { time = context.time + 1 }
        , context
        )

    else
        ( ecs, context )

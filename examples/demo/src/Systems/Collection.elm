module Systems.Collection exposing (update)

import Components exposing (Collectable, Collector, Position, Velocity)
import Components.Transforms as Transforms
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
    -- FIXME no iterate2 * iterate2
    Ecs.iterate2 Ecs.collectableComponent Ecs.positionComponent checkCollectable


checkCollectable :
    Ecs.EntityId
    -> Collectable
    -> Position
    -> ( Ecs, Context )
    -> ( Ecs, Context )
checkCollectable entityId _ position =
    Ecs.iterate2
        Ecs.collectorComponent
        Ecs.positionComponent
        (checkCollection (CollectableEntity entityId position))


checkCollection :
    CollectableEntity
    -> Ecs.EntityId
    -> Collector
    -> Position
    -> ( Ecs, Context )
    -> ( Ecs, Context )
checkCollection collectable entityId collector position ( ecs, context ) =
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
            |> Ecs.remove collectable.id Ecs.collectableComponent
            |> Ecs.insert
                collectable.id
                Ecs.velocityComponent
                (Velocity 0 0 (2 * pi))
            |> Ecs.insert
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
            |> Ecs.update
                collectable.id
                Ecs.transformsComponent
                (Transforms.add (context.time + 1) Transforms.DestroyEntity)
        , context
        )

    else
        ( ecs, context )

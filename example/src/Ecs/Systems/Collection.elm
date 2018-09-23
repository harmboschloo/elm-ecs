module Ecs.Systems.Collection exposing (update)

import Animation
import Ease
import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Collectable, Collector, Position, Scale, Velocity)
import Ecs.Context exposing (Context)


type alias CollectableEntity =
    { id : EntityId
    , position : Position
    }


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterateEntities2 Ecs.collectable Ecs.position checkCollectable


checkCollectable :
    EntityId
    -> Collectable
    -> Position
    -> ( Ecs, Context )
    -> ( Ecs, Context )
checkCollectable entityId collectable position =
    Ecs.iterateEntities2
        Ecs.collector
        Ecs.position
        (checkCollection (CollectableEntity entityId position))


checkCollection :
    CollectableEntity
    -> EntityId
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
            |> Ecs.removeComponent collectable.id Ecs.collectable
            |> Ecs.insertComponent collectable.id Ecs.velocity (Velocity 0 0 (2 * pi))
            |> Ecs.insertComponent collectable.id Ecs.scale 1
            |> Ecs.insertComponent
                collectable.id
                Ecs.scaleAnimation
                (Animation.animation context.time
                    |> Animation.from 1
                    |> Animation.to 0
                    |> Animation.duration 1
                    |> Animation.ease Ease.inBack
                )
            |> Ecs.insertComponent collectable.id Ecs.destroy { time = context.time + 1 }
        , context
        )

    else
        ( ecs, context )

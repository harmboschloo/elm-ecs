module Ecs.Systems.Collection exposing (update)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Collectable, Collector, Position)
import Ecs.Context exposing (Context)
import Ecs.Entities exposing (createCollectableWithId)


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
        createCollectableWithId
            collectable.id
            ( Ecs.resetEntity collectable.id ecs, context )

    else
        ( ecs, context )

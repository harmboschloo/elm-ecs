module Systems.Collection exposing (update)

import Components exposing (Collectable, Collector, Position, Velocity)
import Components.Transforms as Transforms
import Context exposing (Context)
import Data.Animation as Animation
import Data.Bounds as Bounds
import Data.CollisionGrid as CollisionGrid exposing (CollisionGrid)
import Ease
import Ecs exposing (CollectableNode, CollectorNode, Ecs)


type alias CollectorData =
    { id : Ecs.EntityId
    , position : Position
    , radius : Float
    }


type alias CollectableData =
    { id : Ecs.EntityId
    , position : Position
    }


gridConfig : CollisionGrid.Config
gridConfig =
    { cellWidth = 60
    , cellHeight = 60
    }


update : ( Ecs, Context ) -> ( Ecs, Context )
update ( ecs, context ) =
    let
        ( _, collectorGrid ) =
            Ecs.iterate
                Ecs.collectorNode
                insertCollector
                ( ecs, CollisionGrid.empty gridConfig )

        ( _, collectableGrid ) =
            Ecs.iterate
                Ecs.collectableNode
                insertCollectable
                ( ecs, CollisionGrid.empty gridConfig )
    in
    List.foldl
        checkCollection
        ( ecs, context )
        (CollisionGrid.cellCollisionsBetween collectableGrid collectorGrid)


insertCollector :
    Ecs.EntityId
    -> CollectorNode
    -> ( Ecs, CollisionGrid CollectorData )
    -> ( Ecs, CollisionGrid CollectorData )
insertCollector entityId { collector, position } ( ecs, grid ) =
    ( ecs
    , CollisionGrid.insert
        (Bounds.fromPositionAndRadius position.x position.y collector.radius)
        (CollectorData entityId position collector.radius)
        grid
    )


insertCollectable :
    Ecs.EntityId
    -> CollectableNode
    -> ( Ecs, CollisionGrid CollectableData )
    -> ( Ecs, CollisionGrid CollectableData )
insertCollectable entityId { position } ( ecs, grid ) =
    ( ecs
    , CollisionGrid.insertAtPoint
        ( position.x, position.y )
        (CollectableData entityId position)
        grid
    )


checkCollection :
    ( CollectableData, CollectorData )
    -> ( Ecs, Context )
    -> ( Ecs, Context )
checkCollection ( collectable, collector ) ( ecs, context ) =
    let
        deltaX =
            collectable.position.x - collector.position.x

        deltaY =
            collectable.position.y - collector.position.y

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

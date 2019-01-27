module Systems.Collision exposing (update)

import Animation.Sequence as Animation
import Components exposing (Position, Velocity)
import Components.CollisionShape as CollisionShape exposing (CollisionShape)
import Components.DelayedOperations as DelayedOperations
import Ecs
import Ecs.Select
import Global exposing (Global)
import Systems.Collision.Grid as Grid exposing (CollisionGrid)
import World exposing (EntityId, Selector, World, specs)


type alias Collidable =
    { collisionShape : CollisionShape
    , position : Position
    }


collidableSelector : Selector Collidable
collidableSelector =
    Ecs.Select.select2 Collidable
        specs.collisionShape
        specs.position


update : ( World, Global ) -> ( World, Global )
update ( world, global ) =
    Ecs.selectAll collidableSelector world
        |> List.foldl insertEntity Grid.empty
        |> Grid.collisions Grid.starCenter Grid.shipScoop
        |> List.foldl handleStarShipCollisions ( world, global )


insertEntity : ( EntityId, Collidable ) -> CollisionGrid -> CollisionGrid
insertEntity ( entityId, { collisionShape, position } ) grid =
    Grid.insert
        position
        collisionShape.shape
        entityId
        collisionShape.category
        grid


handleStarShipCollisions :
    ( Grid.Item, Grid.Item )
    -> ( World, Global )
    -> ( World, Global )
handleStarShipCollisions ( starItem, _ ) ( world, global ) =
    let
        time =
            Global.getTime global

        starEntityId =
            starItem.data
    in
    ( world
        |> Ecs.remove specs.collisionShape starEntityId
        |> Ecs.insert specs.velocity
            starEntityId
            (Velocity 0 0 (2 * pi))
        |> Ecs.insert specs.scaleAnimation
            starEntityId
            (Animation.animation
                { startTime = time
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
        |> Ecs.update specs.delayedOperations
            starEntityId
            (DelayedOperations.add
                (time + 1)
                DelayedOperations.RemoveEntity
            )
    , global
    )

module Systems.Collision exposing (update)

import Components exposing (Position, Velocity)
import Components.CollisionShape as CollisionShape exposing (CollisionShape)
import Components.DelayedOperations as DelayedOperations
import Data.Animation as Animation
import Ecs exposing (Ecs)
import Global exposing (Global)
import Systems.Collision.Grid as Grid exposing (CollisionGrid)


type alias Collidable =
    { collisionShape : CollisionShape
    , position : Position
    }


collidableSelector : Ecs.Selector Collidable
collidableSelector =
    Ecs.select2 Collidable
        .collisionShape
        .position


update : ( Global, Ecs ) -> ( Global, Ecs )
update ( global, ecs ) =
    Ecs.selectList collidableSelector ecs
        |> List.foldl insertEntity Grid.empty
        |> Grid.collisions Grid.starCenter Grid.shipScoop
        |> List.foldl handleStarShipCollisions ( global, ecs )


insertEntity : ( Ecs.EntityId, Collidable ) -> CollisionGrid -> CollisionGrid
insertEntity ( entityId, { collisionShape, position } ) grid =
    Grid.insert
        position
        collisionShape.shape
        entityId
        collisionShape.category
        grid


handleStarShipCollisions :
    ( Grid.Item, Grid.Item )
    -> ( Global, Ecs )
    -> ( Global, Ecs )
handleStarShipCollisions ( starItem, _ ) ( global, ecs ) =
    let
        time =
            Global.getTime global

        starEntityId =
            starItem.data
    in
    ( global
    , ecs
        |> Ecs.remove .collisionShape starEntityId
        |> Ecs.insert .velocity starEntityId (Velocity 0 0 (2 * pi))
        |> Ecs.insert .scaleAnimation
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
        |> Ecs.update .delayedOperations
            starEntityId
            (DelayedOperations.add (time + 1) DelayedOperations.RemoveEntity)
    )

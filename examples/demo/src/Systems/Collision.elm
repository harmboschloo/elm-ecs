module Systems.Collision exposing (update)

import Core.Animation.Sequence as Animation
import Core.Collidable as Collidable exposing (Collidable)
import Core.Collision.Grid as CollisionGrid
import Core.Dynamics.Position exposing (Position)
import Core.Dynamics.Velocity exposing (Velocity)
import Ecs
import Ecs.Select
import Timing.Timer as Timer
import World exposing (World)
import World.DelayedOperations as DelayedOperations


type alias CollisionGrid =
    CollisionGrid.CollisionGrid Collidable.Category Ecs.EntityId


type alias CollisionItem =
    CollisionGrid.Item Ecs.EntityId


type alias CollidableEntity =
    { collidable : Collidable
    , position : Position
    }


gridCellSize : Float
gridCellSize =
    60


emptyCollisionGrid : CollisionGrid
emptyCollisionGrid =
    CollisionGrid.empty gridCellSize gridCellSize


collidableSelector : World.Selector CollidableEntity
collidableSelector =
    Ecs.Select.select2 CollidableEntity
        World.componentSpecs.collidable
        World.componentSpecs.position


update : World -> World
update world =
    Ecs.selectAll collidableSelector world
        |> List.foldl insertEntity emptyCollisionGrid
        |> CollisionGrid.collisions
            Collidable.starCenter
            Collidable.shipScoop
        |> List.foldl handleStarShipCollisions world


insertEntity : ( Ecs.EntityId, CollidableEntity ) -> CollisionGrid -> CollisionGrid
insertEntity ( entityId, { collidable, position } ) grid =
    CollisionGrid.insert
        position
        collidable.shape
        entityId
        collidable.category
        grid


handleStarShipCollisions : ( CollisionItem, CollisionItem ) -> World -> World
handleStarShipCollisions ( starItem, _ ) world =
    let
        timer =
            Ecs.getSingleton World.singletonSpecs.timer world

        elapsedTime =
            Timer.elapsedTime timer

        starEntityId =
            starItem.data
    in
    world
        |> Ecs.removeComponent World.componentSpecs.collidable starEntityId
        |> Ecs.insertComponent World.componentSpecs.velocity
            starEntityId
            (Velocity 0 0 (2 * pi))
        |> Ecs.insertComponent World.componentSpecs.scaleAnimation
            starEntityId
            (Animation.animation
                { startTime = elapsedTime
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
        |> Ecs.updateComponent World.componentSpecs.delayedOperations
            starEntityId
            (DelayedOperations.add
                (elapsedTime + 1)
                DelayedOperations.RemoveEntity
            )

module Systems.Collision exposing (update)

import Components exposing (Position, Velocity)
import Components.CollisionShape as CollisionShape exposing (CollisionShape)
import Components.DelayedOperations as DelayedOperations
import Data.Animation as Animation
import Entities exposing (Entities, Selector)
import EntityId exposing (EntityId)
import Global exposing (Global)
import Systems.Collision.Grid as Grid exposing (CollisionGrid)


type alias Collidable =
    { collisionShape : CollisionShape
    , position : Position
    }


collidableSelector : Selector Collidable
collidableSelector =
    Entities.select2 Collidable
        .collisionShape
        .position


update : ( Global, Entities ) -> ( Global, Entities )
update ( global, entities ) =
    Entities.selectList collidableSelector entities
        |> List.foldl insertEntity Grid.empty
        |> Grid.collisions Grid.starCenter Grid.shipScoop
        |> List.foldl handleStarShipCollisions ( global, entities )


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
    -> ( Global, Entities )
    -> ( Global, Entities )
handleStarShipCollisions ( starItem, _ ) ( global, entities ) =
    let
        time =
            Global.getTime global

        starEntityId =
            starItem.data
    in
    ( global
    , Entities.updateEcs
        (\ecs ->
            ecs
                |> Entities.remove .collisionShape starEntityId
                |> Entities.insert .velocity
                    starEntityId
                    (Velocity 0 0 (2 * pi))
                |> Entities.insert .scaleAnimation
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
                |> Entities.update .delayedOperations
                    starEntityId
                    (DelayedOperations.add
                        (time + 1)
                        DelayedOperations.RemoveEntity
                    )
        )
        entities
    )

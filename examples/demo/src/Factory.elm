module Factory exposing (createStar, createWorld)

import Collision.Shape as Shape
import Components.ActiveKeys as ActiveKeys
import Components.Assets exposing (Assets)
import Components.CollisionShape as CollisionShape exposing (CollisionShape)
import Components.DelayedOperations as DelayedOperations
import Components.Player exposing (Player)
import Components.Position exposing (Position)
import Components.RandomSeed exposing (RandomSeed)
import Components.ShipControls as ShipControls
import Components.Sprite exposing (Sprite)
import Components.Velocity exposing (Velocity)
import Domains.Animation.Sequence as Animation
import Ecs
import Helpers.Random
import Random
import Config.ControlMapping
import Config.Ship
import Config.SpawnConfig
import Config.ViewConfig
import Timing.Timer as Timer
import Utils
import World exposing (World)


type alias ScreenSize =
    { width : Int
    , height : Int
    }


createWorld : Assets -> RandomSeed -> ScreenSize -> World
createWorld assets randomSeed screen =
    initSingletons assets randomSeed screen
        |> Ecs.emptyWorld World.componentSpecs.all
        |> createPlayerShip
        |> Utils.times 10 createAiShip
        |> Utils.times 30 createStar


initSingletons : Assets -> RandomSeed -> ScreenSize -> World.Singletons
initSingletons assets randomSeed screenSize =
    World.initSingletons
        ActiveKeys.empty
        assets
        Config.ControlMapping.default
        randomSeed
        Config.SpawnConfig.default
        Timer.init
        (Config.ViewConfig.fromScreenSize
            screenSize.width
            screenSize.height
        )


createPlayerShip : World -> World
createPlayerShip world1 =
    let
        assets =
            Ecs.getSingleton World.singletonSpecs.assets world1

        viewConfig =
            Ecs.getSingleton World.singletonSpecs.viewConfig world1

        ( angle, world2 ) =
            Helpers.Random.step Helpers.Random.angleGenerator world1
    in
    world2
        |> Ecs.createEntity
        |> withShipComponents
            assets.sprites.playerShip
            { x = viewConfig.world.width / 2
            , y = viewConfig.world.height / 2
            , angle = angle
            }
        |> Ecs.andInsertComponent World.componentSpecs.player ()
        |> Tuple.second


createAiShip : World -> World
createAiShip world1 =
    let
        assets =
            Ecs.getSingleton World.singletonSpecs.assets world1

        viewConfig =
            Ecs.getSingleton World.singletonSpecs.viewConfig world1

        ( position, world2 ) =
            Helpers.Random.step
                (Helpers.Random.positionGenerator viewConfig.world)
                world1
    in
    world2
        |> Ecs.createEntity
        |> withShipComponents assets.sprites.aiShip position
        |> Ecs.andInsertComponent World.componentSpecs.ai { target = Nothing }
        |> Tuple.second


withShipComponents :
    Sprite
    -> Position
    -> ( Ecs.EntityId, World )
    -> ( Ecs.EntityId, World )
withShipComponents sprite position =
    Ecs.andInsertComponent World.componentSpecs.sprite sprite
        >> Ecs.andInsertComponent World.componentSpecs.position position
        >> Ecs.andInsertComponent World.componentSpecs.shipControls
            (ShipControls.init 0 0)
        >> Ecs.andInsertComponent World.componentSpecs.motion
            Config.Ship.motion
        >> Ecs.andInsertComponent World.componentSpecs.velocity (Velocity 0 0 0)
        >> Ecs.andInsertComponent World.componentSpecs.collisionShape
            (CollisionShape
                (Shape.circle 30)
                CollisionShape.shipScoop
            )


createStar : World -> World
createStar world1 =
    let
        assets =
            Ecs.getSingleton World.singletonSpecs.assets world1

        timer =
            Ecs.getSingleton World.singletonSpecs.timer world1

        elapsedTime =
            Timer.elapsedTime timer

        viewConfig =
            Ecs.getSingleton World.singletonSpecs.viewConfig world1

        ( position, world2 ) =
            Helpers.Random.step
                (Helpers.Random.positionGenerator viewConfig.world)
                world1

        ( delay, world3 ) =
            Helpers.Random.step (Random.float 0 1) world2
    in
    world3
        |> Ecs.createEntity
        |> Ecs.andInsertComponent World.componentSpecs.star ()
        |> Ecs.andInsertComponent World.componentSpecs.sprite assets.sprites.star
        |> Ecs.andInsertComponent World.componentSpecs.position position
        |> Ecs.andInsertComponent World.componentSpecs.velocity
            (Velocity 0 0 (pi / 4))
        |> Ecs.andInsertComponent World.componentSpecs.scale 0
        |> Ecs.andInsertComponent World.componentSpecs.scaleAnimation
            (Animation.animation
                { startTime = elapsedTime
                , duration = 0.5
                , from = 0
                , to = 1
                }
                |> Animation.delay delay
            )
        |> Ecs.andUpdateComponent World.componentSpecs.delayedOperations
            (DelayedOperations.add
                (elapsedTime + delay + 0.5)
                (DelayedOperations.InsertCollisionShape
                    (CollisionShape
                        Shape.point
                        CollisionShape.starCenter
                    )
                )
            )
        |> Tuple.second

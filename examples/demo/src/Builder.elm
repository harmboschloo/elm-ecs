module Builder exposing
    ( createInitalEntities
    , createStar
    )

import Animation.Sequence as Animation
import Collision.Shape as Shape
import Components
    exposing
        ( Motion
        , Position
        , Sprite
        , Velocity
        )
import Components.CollisionShape as CollisionShape exposing (CollisionShape)
import Components.Controls as Controls
import Components.DelayedOperations as DelayedOperations
import Ecs
import Global exposing (Global)
import KeyCode
import Random exposing (Generator)
import Utils exposing (times)
import World exposing (EntityId, World, specs)


createInitalEntities : ( World, Global ) -> ( World, Global )
createInitalEntities ( world, global ) =
    ( world, global )
        |> createPlayerShip
        |> times 10 createAiShip
        |> times 30 createStar


shipMotion : Motion
shipMotion =
    { maxAcceleration = 600
    , maxDeceleration = 400
    , maxAngularAcceleration = 20
    , maxAngularVelocity = 5
    }


createPlayerShip : ( World, Global ) -> ( World, Global )
createPlayerShip ( world1, global1 ) =
    let
        assets =
            Global.getAssets global1

        world =
            Global.getWorld global1

        ( angle, global2 ) =
            Global.randomStep angleGenerator global1

        ( world2, entityId ) =
            Ecs.create world1

        world3 =
            world2
                |> setShipComponents
                    entityId
                    assets.sprites.playerShip
                    { x = world.width / 2
                    , y = world.height / 2
                    , angle = angle
                    }
                |> Ecs.insert specs.keyControlsMap
                    entityId
                    { accelerate = KeyCode.arrowUp
                    , decelerate = KeyCode.arrowDown
                    , rotateLeft = KeyCode.arrowLeft
                    , rotateRight = KeyCode.arrowRight
                    }
    in
    ( world3, global2 )


createAiShip : ( World, Global ) -> ( World, Global )
createAiShip ( world1, global1 ) =
    let
        assets =
            Global.getAssets global1

        world =
            Global.getWorld global1

        ( position, global2 ) =
            Global.randomStep (positionGenerator world) global1

        ( world2, entityId ) =
            Ecs.create world1

        world3 =
            world2
                |> setShipComponents
                    entityId
                    assets.sprites.aiShip
                    position
                |> Ecs.insert specs.ai entityId { target = Nothing }
    in
    ( world3, global2 )


setShipComponents : EntityId -> Sprite -> Position -> World -> World
setShipComponents entityId sprite position world =
    world
        |> Ecs.insert specs.sprite entityId sprite
        |> Ecs.insert specs.position entityId position
        |> Ecs.insert specs.controls entityId (Controls.controls 0 0)
        |> Ecs.insert specs.motion entityId shipMotion
        |> Ecs.insert specs.velocity entityId (Velocity 0 0 0)
        |> Ecs.insert specs.collisionShape
            entityId
            (CollisionShape
                (Shape.circle 30)
                CollisionShape.shipScoop
            )


createStar : ( World, Global ) -> ( World, Global )
createStar ( world1, global1 ) =
    let
        assets =
            Global.getAssets global1

        world =
            Global.getWorld global1

        time =
            Global.getTime global1

        ( position, global2 ) =
            Global.randomStep (positionGenerator world) global1

        ( delay, global3 ) =
            Global.randomStep (Random.float 0 1) global2

        ( world2, entityId ) =
            Ecs.create world1

        world3 =
            world2
                |> Ecs.insert specs.star entityId ()
                |> Ecs.insert specs.sprite entityId assets.sprites.star
                |> Ecs.insert specs.position entityId position
                |> Ecs.insert specs.velocity
                    entityId
                    (Velocity 0 0 (pi / 4))
                |> Ecs.insert specs.scale entityId 0
                |> Ecs.insert specs.scaleAnimation
                    entityId
                    (Animation.animation
                        { startTime = time
                        , duration = 0.5
                        , from = 0
                        , to = 1
                        }
                        |> Animation.delay delay
                    )
                |> Ecs.update specs.delayedOperations
                    entityId
                    (DelayedOperations.add
                        (time + delay + 0.5)
                        (DelayedOperations.InsertCollisionShape
                            (CollisionShape
                                Shape.point
                                CollisionShape.starCenter
                            )
                        )
                    )
    in
    ( world3, global3 )



-- GENERATORS --


positionGenerator : Global.World -> Generator Position
positionGenerator world =
    let
        marginX =
            world.width * 0.1

        marginY =
            world.height * 0.1
    in
    Random.map3 Position
        (Random.float marginX (world.width - marginX))
        (Random.float marginY (world.height - marginY))
        angleGenerator


angleGenerator : Generator Float
angleGenerator =
    Random.float 0 (2 * pi)

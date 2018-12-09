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
import Entities exposing (Ecs, Entities)
import EntityId exposing (EntityId)
import Global exposing (Global)
import KeyCode
import Random exposing (Generator)
import Utils exposing (times)


createInitalEntities : ( Global, Entities ) -> ( Global, Entities )
createInitalEntities ( global, entities ) =
    ( global, entities )
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


createPlayerShip : ( Global, Entities ) -> ( Global, Entities )
createPlayerShip ( global1, entities1 ) =
    let
        assets =
            Global.getAssets global1

        world =
            Global.getWorld global1

        ( angle, global2 ) =
            Global.randomStep angleGenerator global1

        ( entityId, entities2 ) =
            Entities.addEntity entities1

        entities3 =
            Entities.updateEcs
                (\ecs ->
                    ecs
                        |> setShipComponents
                            entityId
                            assets.sprites.playerShip
                            { x = world.width / 2
                            , y = world.height / 2
                            , angle = angle
                            }
                        |> Entities.insert .keyControlsMap
                            entityId
                            { accelerate = KeyCode.arrowUp
                            , decelerate = KeyCode.arrowDown
                            , rotateLeft = KeyCode.arrowLeft
                            , rotateRight = KeyCode.arrowRight
                            }
                )
                entities2
    in
    ( global2, entities3 )


createAiShip : ( Global, Entities ) -> ( Global, Entities )
createAiShip ( global1, entities1 ) =
    let
        assets =
            Global.getAssets global1

        world =
            Global.getWorld global1

        ( position, global2 ) =
            Global.randomStep (positionGenerator world) global1

        ( entityId, entities2 ) =
            Entities.addEntity entities1

        entities3 =
            Entities.updateEcs
                (\ecs ->
                    ecs
                        |> setShipComponents
                            entityId
                            assets.sprites.aiShip
                            position
                        |> Entities.insert .ai entityId { target = Nothing }
                )
                entities2
    in
    ( global2, entities3 )


setShipComponents : EntityId -> Sprite -> Position -> Ecs -> Ecs
setShipComponents entityId sprite position ecs =
    ecs
        |> Entities.insert .sprite entityId sprite
        |> Entities.insert .position entityId position
        |> Entities.insert .controls entityId (Controls.controls 0 0)
        |> Entities.insert .motion entityId shipMotion
        |> Entities.insert .velocity entityId (Velocity 0 0 0)
        |> Entities.insert .collisionShape
            entityId
            (CollisionShape
                (Shape.circle 30)
                CollisionShape.shipScoop
            )


createStar : ( Global, Entities ) -> ( Global, Entities )
createStar ( global1, entities1 ) =
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

        ( entityId, entities2 ) =
            Entities.addEntity entities1

        entities3 =
            Entities.updateEcs
                (\ecs ->
                    ecs
                        |> Entities.insert .star entityId ()
                        |> Entities.insert .sprite entityId assets.sprites.star
                        |> Entities.insert .position entityId position
                        |> Entities.insert .velocity
                            entityId
                            (Velocity 0 0 (pi / 4))
                        |> Entities.insert .scale entityId 0
                        |> Entities.insert .scaleAnimation
                            entityId
                            (Animation.animation
                                { startTime = time
                                , duration = 0.5
                                , from = 0
                                , to = 1
                                }
                                |> Animation.delay delay
                            )
                        |> Entities.update .delayedOperations
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
                )
                entities2
    in
    ( global3, entities3 )



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

module Entities exposing (createCollectable, init)

import Assets exposing (Assets, Spritesheet)
import Components
    exposing
        ( Collector
        , Motion
        , Position
        , Sprite
        , Velocity
        )
import Components.Controls exposing (controls)
import Components.Transforms as Transforms
import Context exposing (Context)
import Data.Animation as Animation
import Data.KeyCode as KeyCode
import Ecs exposing (Ecs, EntityId)
import Random exposing (Generator)
import Utils exposing (times)
import WebGL.Texture exposing (Texture)


init : Context -> ( Ecs, Context )
init context =
    ( Ecs.empty, context )
        |> times 10 createAiCollector
        |> createPlayerCollector
        |> times 30 createCollectable


createPlayerCollector : ( Ecs, Context ) -> ( Ecs, Context )
createPlayerCollector ( ecs, context ) =
    let
        ( ecs2, entityId ) =
            Ecs.create ecs

        ( angle, context2 ) =
            Context.randomStep randomAngleGenerator context

        ecs3 =
            ecs2
                |> insertCollectorComponents
                    entityId
                    context2.assets.sprites.playerShip
                    { x = context.world.width / 2
                    , y = context.world.height / 2
                    , angle = angle
                    }
                |> Ecs.insert
                    entityId
                    Ecs.keyControlsMapComponent
                    { accelerate = KeyCode.arrowUp
                    , decelerate = KeyCode.arrowDown
                    , rotateLeft = KeyCode.arrowLeft
                    , rotateRight = KeyCode.arrowRight
                    }
    in
    ( ecs3, context2 )


randomPositionGenerator : Context -> Generator Position
randomPositionGenerator context =
    Random.map3 Position
        (Random.float 0 context.world.width)
        (Random.float 0 context.world.height)
        randomAngleGenerator


randomAngleGenerator : Generator Float
randomAngleGenerator =
    Random.float 0 (2 * pi)


createAiCollector : ( Ecs, Context ) -> ( Ecs, Context )
createAiCollector ( ecs, context ) =
    let
        ( ecs2, entityId ) =
            Ecs.create ecs

        ( position, context2 ) =
            Context.randomStep (randomPositionGenerator context) context

        ecs3 =
            ecs2
                |> insertCollectorComponents
                    entityId
                    context2.assets.sprites.aiShip
                    position
                |> Ecs.insert entityId Ecs.aiComponent ()
    in
    ( ecs3, context2 )


insertCollectorComponents : EntityId -> Sprite -> Position -> Ecs -> Ecs
insertCollectorComponents entityId sprite position =
    Ecs.insert entityId Ecs.spriteComponent sprite
        >> Ecs.insert entityId Ecs.positionComponent position
        >> Ecs.insert entityId Ecs.controlsComponent (controls 0 0)
        >> Ecs.insert entityId Ecs.motionComponent shipMotion
        >> Ecs.insert entityId Ecs.velocityComponent (Velocity 0 0 0)
        >> Ecs.insert entityId Ecs.collectorComponent (Collector 30)


shipMotion : Motion
shipMotion =
    { maxAcceleration = 600
    , maxDeceleration = 400
    , maxAngularAcceleration = 20
    , maxAngularVelocity = 5
    }


createCollectable : ( Ecs, Context ) -> ( Ecs, Context )
createCollectable ( ecs, context ) =
    let
        ( ecs2, entityId ) =
            Ecs.create ecs
    in
    createCollectableWithId entityId ( ecs2, context )


createCollectableWithId : EntityId -> ( Ecs, Context ) -> ( Ecs, Context )
createCollectableWithId entityId ( ecs, context ) =
    let
        ( position, context2 ) =
            Context.randomStep (randomPositionGenerator context) context

        ( delay, seed ) =
            Random.step (Random.float 0 1) context2.seed

        context3 =
            { context2 | seed = seed }

        ecs2 =
            ecs
                |> Ecs.insert entityId Ecs.spriteComponent context.assets.sprites.collectable
                |> Ecs.insert entityId Ecs.positionComponent position
                |> Ecs.insert entityId Ecs.velocityComponent (Velocity 0 0 (pi / 4))
                |> Ecs.insert entityId Ecs.scaleComponent 0
                |> Ecs.insert
                    entityId
                    Ecs.scaleAnimationComponent
                    (Animation.animation
                        { startTime = context.time
                        , duration = 0.5
                        , from = 0
                        , to = 1
                        }
                        |> Animation.delay delay
                    )
                |> Ecs.update
                    entityId
                    Ecs.transformsComponent
                    (Transforms.add
                        (context.time + delay + 0.5)
                        (Transforms.InsertCollectable ())
                    )
    in
    ( ecs2, context3 )

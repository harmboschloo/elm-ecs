module Systems.ShipDynamics exposing (update)

import Components.Position exposing (Position)
import Components.ShipControls as ShipControls exposing (ShipControls)
import Components.Velocity exposing (Velocity)
import Core.Dynamics.Ship.Limits exposing (Limits)
import Ecs
import Ecs.Select
import Timing.Timer as Timer
import World exposing (World)


type alias MotionControl =
    { controls : ShipControls
    , motion : Motion
    , position : Position
    , velocity : Velocity
    }


motionControlSelector : World.Selector MotionControl
motionControlSelector =
    Ecs.Select.select4 MotionControl
        World.componentSpecs.shipControls
        World.componentSpecs.motion
        World.componentSpecs.position
        World.componentSpecs.velocity


update : World -> World
update world =
    let
        timer =
            Ecs.getSingleton World.singletonSpecs.timer world
    in
    case Timer.lastDelta timer of
        Just deltaTime ->
            Ecs.processAll motionControlSelector (updateEntity deltaTime) world

        Nothing ->
            world


updateEntity :
    Float
    -> ( Ecs.EntityId, MotionControl )
    -> World
    -> World
updateEntity deltaTime ( entityId, motionControl ) world =
    Ecs.insertComponent World.componentSpecs.velocity
        entityId
        (applyControls motionControl deltaTime)
        world


applyControls : MotionControl -> Float -> Velocity
applyControls { controls, motion, position, velocity } deltaTime =
    let
        accelerationControls =
            ShipControls.getAcceleration controls

        maxAcceleration =
            if accelerationControls > 0 then
                motion.maxAcceleration

            else
                motion.maxDeceleration

        acceleration =
            accelerationControls * maxAcceleration

        rotationControls =
            ShipControls.getRotation controls

        targetAngularVelocity =
            rotationControls * motion.maxAngularVelocity

        angularAcceleration =
            clamp
                -motion.maxAngularAcceleration
                motion.maxAngularAcceleration
                ((targetAngularVelocity - velocity.angularVelocity) / deltaTime)

        uncheckedAngularVelocity =
            clamp
                -motion.maxAngularVelocity
                motion.maxAngularVelocity
                (velocity.angularVelocity + angularAcceleration * deltaTime)

        angularVelocity =
            if uncheckedAngularVelocity < 0 && velocity.angularVelocity > 0 then
                0

            else if uncheckedAngularVelocity > 0 && velocity.angularVelocity < 0 then
                0

            else
                uncheckedAngularVelocity
    in
    { velocityX = velocity.velocityX + acceleration * cos position.angle * deltaTime
    , velocityY = velocity.velocityY + acceleration * sin position.angle * deltaTime
    , angularVelocity = angularVelocity
    }

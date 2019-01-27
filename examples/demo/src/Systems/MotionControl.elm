module Systems.MotionControl exposing (MotionControl, applyControls, update)

import Components exposing (Motion, Position, Velocity)
import Components.Controls as Controls exposing (Controls)
import Ecs
import Ecs.Select
import Global exposing (Global)
import World exposing (EntityId, Selector, World, specs)


type alias MotionControl =
    { controls : Controls
    , motion : Motion
    , position : Position
    , velocity : Velocity
    }


motionControlSelector : Selector MotionControl
motionControlSelector =
    Ecs.Select.select4 MotionControl
        specs.controls
        specs.motion
        specs.position
        specs.velocity


update : ( World, Global ) -> ( World, Global )
update =
    Ecs.processAllWithState motionControlSelector updateEntity


updateEntity :
    ( EntityId, MotionControl )
    -> ( World, Global )
    -> ( World, Global )
updateEntity ( entityId, motionControl ) ( world, global ) =
    ( Ecs.insert specs.velocity
        entityId
        (applyControls motionControl (Global.getDeltaTime global))
        world
    , global
    )


applyControls : MotionControl -> Float -> Velocity
applyControls { controls, motion, position, velocity } deltaTime =
    let
        accelerationControls =
            Controls.getAcceleration controls

        maxAcceleration =
            if accelerationControls > 0 then
                motion.maxAcceleration

            else
                motion.maxDeceleration

        acceleration =
            accelerationControls * maxAcceleration

        rotationControls =
            Controls.getRotation controls

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

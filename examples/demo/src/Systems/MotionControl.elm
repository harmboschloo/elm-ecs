module Systems.MotionControl exposing (MotionControl, applyControls, update)

import Components exposing (Motion, Position, Velocity)
import Components.Controls as Controls exposing (Controls)
import Entities exposing (Entities, Selector)
import EntityId exposing (EntityId)
import Global exposing (Global)


type alias MotionControl =
    { controls : Controls
    , motion : Motion
    , position : Position
    , velocity : Velocity
    }


motionControlSelector : Selector MotionControl
motionControlSelector =
    Entities.select4 MotionControl
        .controls
        .motion
        .position
        .velocity


update : ( Global, Entities ) -> ( Global, Entities )
update =
    Entities.process motionControlSelector updateEntity


updateEntity :
    ( EntityId, MotionControl )
    -> ( Global, Entities )
    -> ( Global, Entities )
updateEntity ( entityId, motionControl ) ( global, entities ) =
    ( global
    , Entities.updateEcs
        (\ecs ->
            Entities.insert .velocity
                entityId
                (applyControls motionControl (Global.getDeltaTime global))
                ecs
        )
        entities
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

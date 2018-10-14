module Systems.MotionControl exposing (update)

import Components exposing (Motion, Position, Velocity)
import Components.Controls as Controls exposing (Controls)
import Context exposing (Context)
import Ecs exposing (Ecs)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterate Ecs.motionControlNode updateEntity


updateEntity :
    Ecs.EntityId
    -> Ecs.MotionControlNode
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateEntity entityId { controls, motion, position, velocity } ( ecs, context ) =
    ( Ecs.insert
        entityId
        Ecs.velocityComponent
        (applyControls controls motion position velocity context.deltaTime)
        ecs
    , context
    )


applyControls : Controls -> Motion -> Position -> Velocity -> Float -> Velocity
applyControls controls motion position velocity deltaTime =
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

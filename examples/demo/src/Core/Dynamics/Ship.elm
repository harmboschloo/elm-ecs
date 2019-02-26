module Core.Dynamics.Ship exposing (applyControls)

import Core.Dynamics.Position exposing (Position)
import Core.Dynamics.Ship.Controls as Controls exposing (Controls)
import Core.Dynamics.Ship.Limits exposing (Limits)
import Core.Dynamics.Velocity exposing (Velocity)


applyControls : Limits -> Controls -> Float -> Position -> Velocity -> Velocity
applyControls limits controls deltaTime position velocity =
    let
        accelerationControls =
            Controls.getAcceleration controls

        maxAcceleration =
            if accelerationControls > 0 then
                limits.maxAcceleration

            else
                limits.maxDeceleration

        acceleration =
            accelerationControls * maxAcceleration

        rotationControls =
            Controls.getRotation controls

        targetAngularVelocity =
            rotationControls * limits.maxAngularVelocity

        angularAcceleration =
            clamp
                -limits.maxAngularAcceleration
                limits.maxAngularAcceleration
                ((targetAngularVelocity - velocity.angularVelocity) / deltaTime)

        uncheckedAngularVelocity =
            clamp
                -limits.maxAngularVelocity
                limits.maxAngularVelocity
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

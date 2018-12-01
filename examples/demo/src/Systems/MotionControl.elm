module Systems.MotionControl exposing (update)

import Components exposing (Motion, Position, Velocity)
import Components.Controls as Controls exposing (Controls)
import Ecs.Select
import Game exposing (EntityId, Game)


type alias MotionControl =
    { controls : Controls
    , motion : Motion
    , position : Position
    , velocity : Velocity
    }


motionControlSelector : Game.Selector MotionControl
motionControlSelector =
    Ecs.Select.select4 MotionControl
        Game.components.controls
        Game.components.motion
        Game.components.position
        Game.components.velocity


update : Game -> Game
update =
    Game.process motionControlSelector updateEntity


updateEntity : ( EntityId, MotionControl ) -> Game -> Game
updateEntity ( entityId, motionControl ) game =
    Game.insert Game.components.velocity
        entityId
        (applyControls motionControl (Game.getDeltaTime game))
        game


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

module Systems.MotionControl exposing (system)

import Components exposing (Motion, Position, Velocity)
import Components.Controls as Controls exposing (Controls)
import Ecs exposing (Ecs)
import Entity exposing (Entity, components)
import State exposing (State)


type alias MotionControl =
    { controls : Controls
    , motion : Motion
    , position : Position
    , velocity : Velocity
    }


node : Ecs.Node Entity MotionControl
node =
    Ecs.node4 MotionControl
        components.controls
        components.motion
        components.position
        components.velocity


system : Ecs.System Entity State
system =
    Ecs.processor node updateEntity


updateEntity :
    MotionControl
    -> Ecs.EntityId
    -> Ecs Entity
    -> State
    -> ( Ecs Entity, State )
updateEntity motionControl entityId ecs state =
    ( Ecs.set
        components.velocity
        (applyControls motionControl state.deltaTime)
        entityId
        ecs
    , state
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

module Ecs.Systems.MotionControl exposing (update)

import Clamped
import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Controls, Motion, Position, Velocity)


update : Float -> Ecs -> Ecs
update deltaTime ecs =
    ( ecs, deltaTime )
        |> Ecs.processEntities4
            Ecs.controls
            Ecs.motion
            Ecs.velocity
            Ecs.position
            updateEntity
        |> Tuple.first


updateEntity :
    EntityId
    -> Controls
    -> Motion
    -> Velocity
    -> Position
    -> ( Ecs, Float )
    -> ( Ecs, Float )
updateEntity entityId controls motion velocity position ( ecs, deltaTime ) =
    let
        newVelocity =
            applyControls controls motion velocity position deltaTime
    in
    ( Ecs.insertComponent Ecs.velocity newVelocity entityId ecs, deltaTime )


applyControls : Controls -> Motion -> Velocity -> Position -> Float -> Velocity
applyControls controls motion velocity position deltaTime =
    let
        accelerateControls =
            Clamped.get controls.accelerate

        maxAcceleration =
            if accelerateControls > 0 then
                motion.maxAcceleration

            else
                motion.maxDeceleration

        acceleration =
            accelerateControls * maxAcceleration

        rotateControls =
            Clamped.get controls.rotate

        targetAngularVelocity =
            rotateControls * motion.maxAngularVelocity

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

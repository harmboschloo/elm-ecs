module Core.Dynamics exposing (updatePosition)

import Core.Dynamics.Position exposing (Position)
import Core.Dynamics.Velocity exposing (Velocity)


updatePosition : Float -> Velocity -> Position -> Position
updatePosition deltaTime velocity position =
    { x = position.x + velocity.velocityX * deltaTime
    , y = position.y + velocity.velocityY * deltaTime
    , angle = position.angle + velocity.angularVelocity * deltaTime
    }

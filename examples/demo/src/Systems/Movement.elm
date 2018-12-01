module Systems.Movement exposing (update)

import Components exposing (Position, Velocity)
import Ecs.Select
import Game exposing (EntityId, Game)


type alias Movement =
    { position : Position
    , velocity : Velocity
    }


movementSelector : Game.Selector Movement
movementSelector =
    Ecs.Select.select2 Movement
        Game.components.position
        Game.components.velocity


update : Game -> Game
update =
    Game.process movementSelector updateEntity


updateEntity : ( EntityId, Movement ) -> Game -> Game
updateEntity ( entityId, { position, velocity } ) game =
    let
        deltaTime =
            Game.getDeltaTime game
    in
    Game.insert Game.components.position
        entityId
        { x = position.x + velocity.velocityX * deltaTime
        , y = position.y + velocity.velocityY * deltaTime
        , angle = position.angle + velocity.angularVelocity * deltaTime
        }
        game

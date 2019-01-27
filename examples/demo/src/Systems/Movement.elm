module Systems.Movement exposing (update, updatePosition)

import Components exposing (Position, Velocity)
import Ecs
import Ecs.Select
import Global exposing (Global)
import World exposing (EntityId, Selector, World, specs)


type alias Movement =
    { position : Position
    , velocity : Velocity
    }


movementSelector : Selector Movement
movementSelector =
    Ecs.Select.select2 Movement
        specs.position
        specs.velocity


update : ( World, Global ) -> ( World, Global )
update =
    Ecs.processAllWithState movementSelector updateEntity


updateEntity :
    ( EntityId, Movement )
    -> ( World, Global )
    -> ( World, Global )
updateEntity ( entityId, { position, velocity } ) ( world, global ) =
    let
        deltaTime =
            Global.getDeltaTime global
    in
    ( Ecs.insert specs.position
        entityId
        (updatePosition deltaTime velocity position)
        world
    , global
    )


updatePosition : Float -> Velocity -> Position -> Position
updatePosition deltaTime velocity position =
    { x = position.x + velocity.velocityX * deltaTime
    , y = position.y + velocity.velocityY * deltaTime
    , angle = position.angle + velocity.angularVelocity * deltaTime
    }

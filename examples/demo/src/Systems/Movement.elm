module Systems.Movement exposing (update)

import Components exposing (Position, Velocity)
import Ecs exposing (Ecs)
import Global exposing (Global)


type alias Movement =
    { position : Position
    , velocity : Velocity
    }


movementSelector : Ecs.Selector Movement
movementSelector =
    Ecs.select2 Movement
        .position
        .velocity


update : ( Global, Ecs ) -> ( Global, Ecs )
update =
    Ecs.process movementSelector updateEntity


updateEntity : ( Ecs.EntityId, Movement ) -> ( Global, Ecs ) -> ( Global, Ecs )
updateEntity ( entityId, { position, velocity } ) ( global, ecs ) =
    let
        deltaTime =
            Global.getDeltaTime global
    in
    ( global
    , Ecs.insert .position
        entityId
        { x = position.x + velocity.velocityX * deltaTime
        , y = position.y + velocity.velocityY * deltaTime
        , angle = position.angle + velocity.angularVelocity * deltaTime
        }
        ecs
    )

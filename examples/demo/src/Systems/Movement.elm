module Systems.Movement exposing (update)

import Components exposing (Position, Velocity)
import Entities exposing (Entities, EntityId, Selector)
import Global exposing (Global)


type alias Movement =
    { position : Position
    , velocity : Velocity
    }


movementSelector : Selector Movement
movementSelector =
    Entities.select2 Movement
        .position
        .velocity


update : ( Global, Entities ) -> ( Global, Entities )
update =
    Entities.process movementSelector updateEntity


updateEntity :
    ( EntityId, Movement )
    -> ( Global, Entities )
    -> ( Global, Entities )
updateEntity ( entityId, { position, velocity } ) ( global, entities ) =
    let
        deltaTime =
            Global.getDeltaTime global
    in
    ( global
    , Entities.updateEcs
        (\ecs ->
            Entities.insert .position
                entityId
                { x = position.x + velocity.velocityX * deltaTime
                , y = position.y + velocity.velocityY * deltaTime
                , angle = position.angle + velocity.angularVelocity * deltaTime
                }
                ecs
        )
        entities
    )

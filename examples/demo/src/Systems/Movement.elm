module Systems.Movement exposing (update, updatePosition)

import Components exposing (Position, Velocity)
import Entities exposing (Entities, Selector)
import EntityId exposing (EntityId)
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
                (updatePosition deltaTime velocity position)
                ecs
        )
        entities
    )


updatePosition : Float -> Velocity -> Position -> Position
updatePosition deltaTime velocity position =
    { x = position.x + velocity.velocityX * deltaTime
    , y = position.y + velocity.velocityY * deltaTime
    , angle = position.angle + velocity.angularVelocity * deltaTime
    }

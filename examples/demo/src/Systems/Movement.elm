module Systems.Movement exposing (system)

import Components exposing (Position, Velocity)
import Ecs exposing (Ecs)
import Entity exposing (Entity, components)
import State exposing (State)


type alias Movement =
    { position : Position
    , velocity : Velocity
    }


node : Ecs.Node Entity Movement
node =
    Ecs.node2 Movement
        components.position
        components.velocity


system : Ecs.System Entity State
system =
    Ecs.processor node updateEntity


updateEntity :
    Movement
    -> Ecs.EntityId
    -> Ecs Entity
    -> State
    -> ( Ecs Entity, State )
updateEntity { position, velocity } entityId ecs state =
    ( Ecs.set
        components.position
        { x = position.x + velocity.velocityX * state.deltaTime
        , y = position.y + velocity.velocityY * state.deltaTime
        , angle = position.angle + velocity.angularVelocity * state.deltaTime
        }
        entityId
        ecs
    , state
    )

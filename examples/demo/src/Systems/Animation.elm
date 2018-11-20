module Systems.Animation exposing (system)

import Components
import Data.Animation as Animation exposing (Animation)
import Ecs exposing (Ecs)
import Entity exposing (Entity, components)
import State exposing (State)


type alias ScaleAnimation =
    { scaleAnimation : Components.ScaleAnimation
    }


node : Ecs.Node Entity ScaleAnimation
node =
    Ecs.node1 ScaleAnimation
        components.scaleAnimation


system : Ecs.System Entity State
system =
    Ecs.processor node updateScale


updateScale :
    ScaleAnimation
    -> Ecs.EntityId
    -> Ecs Entity
    -> State
    -> ( Ecs Entity, State )
updateScale { scaleAnimation } entityId ecs state =
    let
        ecs2 =
            Ecs.set
                components.scale
                (Animation.animate state.time scaleAnimation)
                entityId
                ecs
    in
    if Animation.hasEnded state.time scaleAnimation then
        ( Ecs.remove components.scaleAnimation entityId ecs2
        , state
        )

    else
        ( ecs2, state )

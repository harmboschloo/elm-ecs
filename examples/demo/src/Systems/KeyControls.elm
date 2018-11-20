module Systems.KeyControls exposing (system)

import Components exposing (KeyControlsMap)
import Components.Controls exposing (Controls, controls)
import Data.KeyCode exposing (KeyCode)
import Ecs exposing (Ecs)
import Entity exposing (Entity, components)
import Set exposing (Set)
import State exposing (State)


type alias KeyControls =
    { keyControlsMap : KeyControlsMap
    , controls : Controls
    }


node : Ecs.Node Entity KeyControls
node =
    Ecs.node2 KeyControls
        components.keyControlsMap
        components.controls


system : Ecs.System Entity State
system =
    Ecs.processor node updateEntity


updateEntity :
    KeyControls
    -> Ecs.EntityId
    -> Ecs Entity
    -> State
    -> ( Ecs Entity, State )
updateEntity { keyControlsMap } entityId ecs state =
    ( Ecs.set
        components.controls
        (updateControls keyControlsMap state.activeKeys)
        entityId
        ecs
    , state
    )


updateControls : KeyControlsMap -> Set KeyCode -> Controls
updateControls keyControlsMap activeKeys =
    let
        acceleration =
            case
                ( Set.member keyControlsMap.accelerate activeKeys
                , Set.member keyControlsMap.decelerate activeKeys
                )
            of
                ( False, False ) ->
                    0

                ( True, True ) ->
                    0

                ( True, False ) ->
                    1

                ( False, True ) ->
                    -1

        rotation =
            case
                ( Set.member keyControlsMap.rotateLeft activeKeys
                , Set.member keyControlsMap.rotateRight activeKeys
                )
            of
                ( False, False ) ->
                    0

                ( True, True ) ->
                    0

                ( True, False ) ->
                    1

                ( False, True ) ->
                    -1
    in
    controls acceleration rotation

module Systems.KeyControls exposing (update)

import Components exposing (KeyControlsMap)
import Components.Controls exposing (Controls, controls)
import Context exposing (Context)
import Data.KeyCode exposing (KeyCode)
import Ecs exposing (Ecs)
import Set exposing (Set)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterate2 Ecs.keyControlsMapComponent Ecs.controlsComponent updateEntity


updateEntity :
    Ecs.EntityId
    -> KeyControlsMap
    -> Controls
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateEntity entityId keyControlsMap controls ( ecs, context ) =
    ( Ecs.insert
        entityId
        Ecs.controlsComponent
        (updateControls keyControlsMap context.activeKeys)
        ecs
    , context
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

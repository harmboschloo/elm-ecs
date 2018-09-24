module Systems.KeyControls exposing (update)

import Components exposing (KeyControlsMap)
import Components.Controls exposing (Controls, controls)
import Context exposing (Context)
import Data.KeyCode exposing (KeyCode)
import Ecs exposing (Ecs, EntityId)
import Set exposing (Set)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterateEntities2 Ecs.keyControlsMap Ecs.controls updateEntity


updateEntity :
    EntityId
    -> KeyControlsMap
    -> Controls
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateEntity entityId keyMap controls ( ecs, context ) =
    ( Ecs.insertComponent
        entityId
        Ecs.controls
        (updateControls keyMap context.activeKeys)
        ecs
    , context
    )


updateControls : KeyControlsMap -> Set KeyCode -> Controls
updateControls keyMap activeKeys =
    let
        acceleration =
            case
                ( Set.member keyMap.accelerate activeKeys
                , Set.member keyMap.decelerate activeKeys
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
                ( Set.member keyMap.rotateLeft activeKeys
                , Set.member keyMap.rotateRight activeKeys
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

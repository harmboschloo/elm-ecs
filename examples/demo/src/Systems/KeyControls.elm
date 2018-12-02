module Systems.KeyControls exposing (update)

import Components exposing (KeyControlsMap)
import Components.Controls exposing (Controls, controls)
import Data.KeyCode exposing (KeyCode)
import Ecs exposing (Ecs)
import Global exposing (Global)
import Set exposing (Set)


keyControlsSelector : Ecs.Selector KeyControlsMap
keyControlsSelector =
    Ecs.component .keyControlsMap
        |> Ecs.andHas .controls


update : ( Global, Ecs ) -> ( Global, Ecs )
update =
    Ecs.process keyControlsSelector updateEntity


updateEntity :
    ( Ecs.EntityId, KeyControlsMap )
    -> ( Global, Ecs )
    -> ( Global, Ecs )
updateEntity ( entityId, keyControlsMap ) ( global, ecs ) =
    ( global
    , Ecs.insert .controls
        entityId
        (updateControls keyControlsMap (Global.getActiveKeys global))
        ecs
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

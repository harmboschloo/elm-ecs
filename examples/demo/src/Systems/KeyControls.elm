module Systems.KeyControls exposing (update)

import Components exposing (KeyControlsMap)
import Components.Controls exposing (Controls, controls)
import Entities exposing (Entities, Selector)
import EntityId exposing (EntityId)
import Global exposing (Global)
import KeyCode exposing (KeyCode)
import Set exposing (Set)


keyControlsSelector : Selector KeyControlsMap
keyControlsSelector =
    Entities.selectComponent .keyControlsMap
        |> Entities.andHas .controls


update : ( Global, Entities ) -> ( Global, Entities )
update =
    Entities.process keyControlsSelector updateEntity


updateEntity :
    ( EntityId, KeyControlsMap )
    -> ( Global, Entities )
    -> ( Global, Entities )
updateEntity ( entityId, keyControlsMap ) ( global, entities ) =
    ( global
    , Entities.updateEcs
        (\ecs ->
            Entities.insert .controls
                entityId
                (updateControls keyControlsMap (Global.getActiveKeys global))
                ecs
        )
        entities
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

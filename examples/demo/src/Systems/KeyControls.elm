module Systems.KeyControls exposing (update)

import Components exposing (KeyControlsMap)
import Components.Controls exposing (Controls, controls)
import Ecs
import Ecs.Select
import Global exposing (Global)
import KeyCode exposing (KeyCode)
import Set exposing (Set)
import World exposing (EntityId, Selector, World, specs)


keyControlsSelector : Selector KeyControlsMap
keyControlsSelector =
    Ecs.Select.component specs.keyControlsMap
        |> Ecs.Select.andHas specs.controls


update : ( World, Global ) -> ( World, Global )
update =
    Ecs.processAllWithState keyControlsSelector updateEntity


updateEntity :
    ( EntityId, KeyControlsMap )
    -> ( World, Global )
    -> ( World, Global )
updateEntity ( entityId, keyControlsMap ) ( world, global ) =
    ( Ecs.insert specs.controls
        entityId
        (updateControls keyControlsMap (Global.getActiveKeys global))
        world
    , global
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

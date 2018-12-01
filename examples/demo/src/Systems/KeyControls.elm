module Systems.KeyControls exposing (update)

import Components exposing (KeyControlsMap)
import Components.Controls exposing (Controls, controls)
import Data.KeyCode exposing (KeyCode)
import Ecs.Select
import Game exposing (EntityId, Game)
import Set exposing (Set)


keyControlsSelector : Game.Selector KeyControlsMap
keyControlsSelector =
    Ecs.Select.component Game.components.keyControlsMap
        |> Ecs.Select.andHas Game.components.controls


update : Game -> Game
update =
    Game.process keyControlsSelector updateEntity


updateEntity : ( EntityId, KeyControlsMap ) -> Game -> Game
updateEntity ( entityId, keyControlsMap ) game =
    Game.insert
        Game.components.controls
        entityId
        (updateControls keyControlsMap (Game.getActiveKeys game))
        game


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

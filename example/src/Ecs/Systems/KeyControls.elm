module Ecs.Systems.KeyControls exposing
    ( KeyChange
    , Keys
    , initKeys
    , keyDownDecoder
    , keyUpDecoder
    , updateEntities
    , updateKeys
    )

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Controls, KeyControlsMap, controls)
import Html.Events
import Json.Decode as Decode exposing (Decoder)
import KeyCode exposing (KeyCode)
import Set exposing (Set)


type Keys
    = ActiveKeys (Set KeyCode)


initKeys : Keys
initKeys =
    ActiveKeys Set.empty


type KeyChange
    = KeyUp KeyCode
    | KeyDown KeyCode


keyUpDecoder : Decoder KeyChange
keyUpDecoder =
    keyDecoder KeyUp


keyDownDecoder : Decoder KeyChange
keyDownDecoder =
    keyDecoder KeyUp


keyDecoder : (KeyCode -> KeyChange) -> Decoder KeyChange
keyDecoder keyChange =
    Html.Events.keyCode
        |> Decode.map keyChange


updateKeys : KeyChange -> Keys -> Keys
updateKeys keyChange (ActiveKeys activeKeys) =
    ActiveKeys <|
        case keyChange of
            KeyUp keyCode ->
                Set.remove keyCode activeKeys

            KeyDown keyCode ->
                Set.insert keyCode activeKeys


updateEntities : Keys -> Ecs -> Ecs
updateEntities (ActiveKeys activeKeys) ecs =
    Ecs.processEntities2
        Ecs.keyControlsMap
        Ecs.controls
        updateEntity
        ( ecs, activeKeys )
        |> Tuple.first


updateEntity :
    EntityId
    -> KeyControlsMap
    -> Controls
    -> ( Ecs, Set KeyCode )
    -> ( Ecs, Set KeyCode )
updateEntity entityId keyMap controls ( ecs, activeKeys ) =
    ( Ecs.insertComponent
        Ecs.controls
        (updateControls keyMap activeKeys)
        entityId
        ecs
    , activeKeys
    )


updateControls : KeyControlsMap -> Set KeyCode -> Controls
updateControls keyMap activeKeys =
    let
        accelerate =
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

        rotate =
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
                    -1

                ( False, True ) ->
                    1
    in
    controls accelerate rotate

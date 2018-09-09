module Ecs.Systems.KeyControls exposing
    ( ControlChange(..)
    , KeyChange(..)
    , controlDecoder
    , update
    )

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Controls)
import Html.Events
import Json.Decode as Decode exposing (Decoder)


type KeyChange
    = KeyUp
    | KeyDown


type ControlChange
    = ControlForward Bool
    | ControlBack Bool
    | ControlLeft Bool
    | ControlRight Bool
    | ControlInvalid


controlDecoder : KeyChange -> Decoder ControlChange
controlDecoder keyChange =
    Html.Events.keyCode
        |> Decode.map
            (\keyCode ->
                case keyCode of
                    37 ->
                        ControlLeft (keyActive keyChange)

                    38 ->
                        ControlForward (keyActive keyChange)

                    39 ->
                        ControlRight (keyActive keyChange)

                    40 ->
                        ControlBack (keyActive keyChange)

                    _ ->
                        ControlInvalid
            )


keyActive : KeyChange -> Bool
keyActive keyChange =
    case keyChange of
        KeyUp ->
            False

        KeyDown ->
            True


update : ControlChange -> Ecs -> Ecs
update controlChange ecs =
    case controlChange of
        ControlForward active ->
            updateControls (\control -> { control | forward = active }) ecs

        ControlBack active ->
            updateControls (\control -> { control | back = active }) ecs

        ControlLeft active ->
            updateControls (\control -> { control | left = active }) ecs

        ControlRight active ->
            updateControls (\control -> { control | right = active }) ecs

        ControlInvalid ->
            ecs


updateControls : (Controls -> Controls) -> Ecs -> Ecs
updateControls updater ecs =
    Ecs.processEntities2
        Ecs.human
        Ecs.controls
        (updateEntity updater)
        ( ecs, () )
        |> Tuple.first


updateEntity :
    (Controls -> Controls)
    -> EntityId
    -> b
    -> Controls
    -> ( Ecs, a )
    -> ( Ecs, a )
updateEntity updater entityId _ controls ( ecs, a ) =
    ( Ecs.insertComponent Ecs.controls (updater controls) entityId ecs
    , a
    )

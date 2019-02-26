module Systems.UserInput exposing
    ( Msg
    , frameUpdate
    , messageUpdate
    , subscriptions
    )

import Browser.Events
import Components.ActiveKeys as ActiveKeys exposing (ActiveKeys)
import Components.ControlMapping exposing (ControlMapping)
import Components.ShipControls as ShipControls exposing (ShipControls)
import Domains.UserInput.KeyCode exposing (KeyCode)
import Ecs
import Ecs.Select
import Html.Events
import Json.Decode as Decode exposing (Decoder)
import Set exposing (Set)
import Config.SpawnConfig
import Timing.Timer as Timer
import World exposing (World)



-- MSG UPDATE --


type Msg
    = KeyDown KeyCode
    | KeyUp KeyCode


messageUpdate : Msg -> World -> World
messageUpdate msg world =
    case msg of
        KeyDown keyCode ->
            world
                |> Ecs.updateSingleton
                    World.singletonSpecs.activeKeys
                    (ActiveKeys.setActive keyCode True)
                |> handleKeyEvent keyCode

        KeyUp keyCode ->
            Ecs.updateSingleton
                World.singletonSpecs.activeKeys
                (ActiveKeys.setActive keyCode False)
                world


handleKeyEvent : KeyCode -> World -> World
handleKeyEvent keyCode world =
    let
        mapping =
            Ecs.getSingleton World.singletonSpecs.controlMapping world
    in
    if mapping.togglePaused == keyCode then
        Ecs.updateSingleton
            World.singletonSpecs.timers
            (\timers -> { timers | base = Timer.toggleRunning timers.base })
            world

    else if mapping.cycleSpawnRate == keyCode then
        Ecs.updateSingleton
            World.singletonSpecs.spawnConfig
            Config.SpawnConfig.nextSpawnRate
            world

    else
        world



-- SUBSCRIPTIONS --


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ Browser.Events.onKeyUp keyUpDecoder
        , Browser.Events.onKeyDown keyDownDecoder
        ]


keyUpDecoder : Decoder Msg
keyUpDecoder =
    Decode.map KeyUp Html.Events.keyCode


keyDownDecoder : Decoder Msg
keyDownDecoder =
    Decode.map KeyDown Html.Events.keyCode



-- FRAME UPDATE --


shipControlsSelector : World.Selector ShipControls
shipControlsSelector =
    Ecs.Select.select2 (\_ controls -> controls)
        World.componentSpecs.player
        World.componentSpecs.shipControls


frameUpdate : World -> World
frameUpdate =
    Ecs.processAll shipControlsSelector updateEntityControls


updateEntityControls :
    ( Ecs.EntityId, ShipControls )
    -> World
    -> World
updateEntityControls ( entityId, _ ) world =
    let
        activeKeys =
            Ecs.getSingleton World.singletonSpecs.activeKeys world

        mapping =
            Ecs.getSingleton World.singletonSpecs.controlMapping world
    in
    Ecs.insertComponent World.componentSpecs.shipControls
        entityId
        (updateControls mapping activeKeys)
        world


updateControls : ControlMapping -> ActiveKeys -> ShipControls
updateControls mapping activeKeys =
    let
        acceleration =
            case
                ( ActiveKeys.isActive mapping.ship.accelerate activeKeys
                , ActiveKeys.isActive mapping.ship.decelerate activeKeys
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
                ( ActiveKeys.isActive mapping.ship.rotateLeft activeKeys
                , ActiveKeys.isActive mapping.ship.rotateRight activeKeys
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
    ShipControls.init acceleration rotation

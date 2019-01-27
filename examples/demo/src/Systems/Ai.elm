module Systems.Ai exposing (update)

import Components exposing (Ai, Motion, Position, Star, Velocity)
import Components.Controls as Controls exposing (Controls)
import Ecs
import Ecs.Select
import Global exposing (Global)
import Systems.MotionControl as MotionControl
import Systems.Movement as Movement
import World exposing (EntityId, Selector, World, specs)


type alias Ship =
    { ai : Ai
    , motion : Motion
    , position : Position
    , velocity : Velocity
    }


shipSelector : Selector Ship
shipSelector =
    Ecs.Select.select4 Ship
        specs.ai
        specs.motion
        specs.position
        specs.velocity
        |> Ecs.Select.andHas specs.controls


type alias Target =
    { star : Star
    , position : Position
    }


targetSelector : Selector Target
targetSelector =
    Ecs.Select.select2 Target
        specs.star
        specs.position
        |> Ecs.Select.andHas specs.collisionShape


update : ( World, Global ) -> ( World, Global )
update =
    Ecs.processAllWithState shipSelector updateEntity


updateEntity : ( EntityId, Ship ) -> ( World, Global ) -> ( World, Global )
updateEntity ( entityId, ship ) ( world, global ) =
    let
        maybeTarget =
            case ship.ai.target of
                Just targetId ->
                    case Ecs.select targetSelector targetId world of
                        Just target ->
                            Just ( targetId, target.position )

                        Nothing ->
                            findTargetFor ship world

                Nothing ->
                    findTargetFor ship world

        ( maybeTargetId, targetPosition ) =
            case maybeTarget of
                Just ( targetId, position ) ->
                    ( Just targetId, position )

                Nothing ->
                    let
                        { width, height } =
                            Global.getWorld global
                    in
                    ( Nothing
                    , { x = width / 2
                      , y = height / 2
                      , angle = 0
                      }
                    )

        controls =
            findControlsForTarget targetPosition ship
    in
    ( Ecs.insert specs.controls entityId controls world
    , global
    )


findTargetFor : Ship -> World -> Maybe ( EntityId, Position )
findTargetFor ship world =
    Ecs.selectAll targetSelector world
        |> List.map
            (\( entityId, target ) ->
                ( entityId
                , target.position
                , calculateDistanceSquared target.position ship
                )
            )
        |> List.sortBy (\( _, _, distanceSquared ) -> distanceSquared)
        |> List.head
        |> Maybe.map (\( entityId, position, _ ) -> ( entityId, position ))


findControlsForTarget : Position -> Ship -> Controls
findControlsForTarget position ship =
    let
        currentDistanceSquared =
            calculateDistanceSquared
                position
                ship

        lookAheadTime =
            clamp 0.01 0.5 (currentDistanceSquared / 100000)
    in
    possibleControls
        |> List.map
            (\( controls1, controls2 ) ->
                ship
                    |> applyControls controls1 lookAheadTime
                    |> applyControls controls2 lookAheadTime
                    |> withDistanceSquared position controls1
            )
        |> List.sortBy .distanceSquared
        |> List.head
        |> Maybe.map .controls
        |> Maybe.withDefault (Controls.controls 0 0)


possibleControls : List ( Controls, Controls )
possibleControls =
    pairs
        [ Controls.controls 0 0
        , Controls.controls -1 0
        , Controls.controls 1 0
        , Controls.controls 0 -1
        , Controls.controls 0 1
        , Controls.controls -1 -1
        , Controls.controls 1 -1
        , Controls.controls 1 1
        , Controls.controls -1 1
        ]


applyControls : Controls -> Float -> Ship -> Ship
applyControls controls deltaTime ship =
    let
        velocity =
            MotionControl.applyControls
                { controls = controls
                , motion = ship.motion
                , position = ship.position
                , velocity = ship.velocity
                }
                deltaTime

        position =
            Movement.updatePosition deltaTime velocity ship.position
    in
    { ai = ship.ai
    , motion = ship.motion
    , position = position
    , velocity = velocity
    }


withDistanceSquared :
    Position
    -> Controls
    -> Ship
    -> { distanceSquared : Float, controls : Controls }
withDistanceSquared targetPosition controls ship =
    { distanceSquared = calculateDistanceSquared targetPosition ship
    , controls = controls
    }


calculateDistanceSquared : Position -> Ship -> Float
calculateDistanceSquared targetPosition ship =
    let
        deltaX =
            ship.position.x - targetPosition.x

        deltaY =
            ship.position.y - targetPosition.y
    in
    deltaX * deltaX + deltaY * deltaY


pairs : List a -> List ( a, a )
pairs list =
    case list of
        [] ->
            []

        head :: tail ->
            List.map (\i -> ( head, i )) tail ++ pairs tail

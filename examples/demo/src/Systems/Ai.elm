module Systems.Ai exposing (update)

import Components exposing (Ai, Motion, Position, Star, Velocity)
import Components.Controls as Controls exposing (Controls)
import Entities exposing (Entities, Selector)
import EntityId exposing (EntityId)
import Global exposing (Global)
import Systems.MotionControl as MotionControl
import Systems.Movement as Movement


type alias Ship =
    { ai : Ai
    , motion : Motion
    , position : Position
    , velocity : Velocity
    }


shipSelector : Selector Ship
shipSelector =
    Entities.select4 Ship
        .ai
        .motion
        .position
        .velocity
        |> Entities.andHas .controls


type alias Target =
    { star : Star
    , position : Position
    }


targetSelector : Selector Target
targetSelector =
    Entities.select2 Target
        .star
        .position
        |> Entities.andHas .collisionShape


update : ( Global, Entities ) -> ( Global, Entities )
update =
    Entities.process shipSelector updateEntity


updateEntity :
    ( EntityId, Ship )
    -> ( Global, Entities )
    -> ( Global, Entities )
updateEntity ( entityId, ship ) ( global, entities ) =
    let
        maybeTarget =
            case ship.ai.target of
                Just targetId ->
                    case Entities.select targetSelector targetId entities of
                        Just target ->
                            Just ( targetId, target.position )

                        Nothing ->
                            findTargetFor ship entities

                Nothing ->
                    findTargetFor ship entities

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
    ( global
    , Entities.updateEcs
        (\ecs -> Entities.insert .controls entityId controls ecs)
        entities
    )


findTargetFor : Ship -> Entities -> Maybe ( EntityId, Position )
findTargetFor ship entities =
    Entities.selectList targetSelector entities
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

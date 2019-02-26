module Core.Ai exposing (Ship, calculateDistanceSquared, findControlsForTarget)

import Core.Dynamics as Dynamics
import Core.Dynamics.Position exposing (Position)
import Core.Dynamics.Ship as ShipDynamics
import Core.Dynamics.Ship.Controls as Controls exposing (Controls)
import Core.Dynamics.Ship.Limits exposing (Limits)
import Core.Dynamics.Velocity exposing (Velocity)


type alias Ship =
    { limits : Limits
    , position : Position
    , velocity : Velocity
    }


findControlsForTarget : Position -> Ship -> Controls
findControlsForTarget targetPosition ship =
    let
        currentDistanceSquared =
            calculateDistanceSquared
                targetPosition
                ship.position

        lookAheadTime =
            clamp 0.01 0.5 (currentDistanceSquared / 100000)
    in
    possibleControls
        |> List.map
            (\( controls1, controls2 ) ->
                ship
                    |> applyControls controls1 lookAheadTime
                    |> applyControls controls2 lookAheadTime
                    |> withDistanceSquared targetPosition controls1
            )
        |> List.sortBy .distanceSquared
        |> List.head
        |> Maybe.map .controls
        |> Maybe.withDefault (Controls.init 0 0)


possibleControls : List ( Controls, Controls )
possibleControls =
    pairs
        [ Controls.init 0 0
        , Controls.init -1 0
        , Controls.init 1 0
        , Controls.init 0 -1
        , Controls.init 0 1
        , Controls.init -1 -1
        , Controls.init 1 -1
        , Controls.init 1 1
        , Controls.init -1 1
        ]


applyControls : Controls -> Float -> Ship -> Ship
applyControls controls deltaTime ship =
    let
        velocity =
            ShipDynamics.applyControls
                ship.limits
                controls
                deltaTime
                ship.position
                ship.velocity

        position =
            Dynamics.updatePosition deltaTime velocity ship.position
    in
    { limits = ship.limits
    , position = position
    , velocity = velocity
    }


withDistanceSquared :
    Position
    -> Controls
    -> Ship
    -> { distanceSquared : Float, controls : Controls }
withDistanceSquared targetPosition controls ship =
    { distanceSquared = calculateDistanceSquared targetPosition ship.position
    , controls = controls
    }


calculateDistanceSquared : Position -> Position -> Float
calculateDistanceSquared targetPosition shipPosition =
    let
        deltaX =
            shipPosition.x - targetPosition.x

        deltaY =
            shipPosition.y - targetPosition.y
    in
    deltaX * deltaX + deltaY * deltaY


pairs : List a -> List ( a, a )
pairs list =
    case list of
        [] ->
            []

        head :: tail ->
            List.map (\i -> ( head, i )) tail ++ pairs tail

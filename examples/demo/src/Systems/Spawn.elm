module Systems.Spawn exposing (system)

import Ecs exposing (Ecs)
import Entity exposing (Entity)
import Random
import State exposing (State)
import Utils


spawnRate : Float
spawnRate =
    -- per second
    5


testSpawnRate : Float
testSpawnRate =
    -- per second
    50


system : Ecs.System Entity State
system =
    Ecs.preProcessor update


update : Ecs Entity -> State -> ( Ecs Entity, State )
update ecs state =
    let
        rate =
            if state.test then
                testSpawnRate

            else
                spawnRate

        spawn =
            rate * state.deltaTime

        fraction =
            spawn - toFloat (floor spawn)

        ( probability, state2 ) =
            State.randomStep (Random.float 0 1) state

        nFraction =
            if probability <= fraction then
                1

            else
                0

        n =
            floor spawn + nFraction
    in
    ( ecs, state2 )
        |> Utils.times n Entity.createStar

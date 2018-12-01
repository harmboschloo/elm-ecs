module Systems.Spawn exposing (update)

import Entities
import Game exposing (Game)
import Random
import Utils


spawnRate : Float
spawnRate =
    -- per second
    5


testSpawnRate : Float
testSpawnRate =
    -- per second
    50


update : Game -> Game
update game1 =
    let
        rate =
            if Game.isTestEnabled game1 then
                testSpawnRate

            else
                spawnRate

        spawn =
            rate * Game.getDeltaTime game1

        fraction =
            spawn - toFloat (floor spawn)

        ( probability, game2 ) =
            Game.randomStep (Random.float 0 1) game1

        nFraction =
            if probability <= fraction then
                1

            else
                0

        n =
            floor spawn + nFraction
    in
    Utils.times n Entities.createStar game2

module Systems.Spawn exposing (update)

import Builder
import Entities exposing (Entities)
import Global exposing (Global)
import Random
import Utils


spawnRate : Float
spawnRate =
    -- per second
    10


testSpawnRate : Float
testSpawnRate =
    -- per second
    50


update : ( Global, Entities ) -> ( Global, Entities )
update ( global1, entities ) =
    let
        rate =
            if Global.isTestEnabled global1 then
                testSpawnRate

            else
                spawnRate

        spawn =
            rate * Global.getDeltaTime global1

        fraction =
            spawn - toFloat (floor spawn)

        ( probability, global2 ) =
            Global.randomStep (Random.float 0 1) global1

        nFraction =
            if probability <= fraction then
                1

            else
                0

        n =
            floor spawn + nFraction
    in
    Utils.times n Builder.createStar ( global2, entities )

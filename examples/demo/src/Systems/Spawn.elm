module Systems.Spawn exposing (update)

import Builder
import Global exposing (Global)
import Random
import Utils
import World exposing (World)


update : ( World, Global ) -> ( World, Global )
update ( world, global1 ) =
    let
        rate =
            Global.getSpawnRate global1

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
    Utils.times n Builder.createStar ( world, global2 )

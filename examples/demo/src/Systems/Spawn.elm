module Systems.Spawn exposing (update)

import Context exposing (Context)
import Ecs exposing (Ecs)
import Entities
import Random
import Utils


spawnRate : Float
spawnRate =
    -- per second
    5


update : ( Ecs, Context ) -> ( Ecs, Context )
update ( ecs, context ) =
    let
        spawn =
            spawnRate * context.deltaTime

        fraction =
            spawn - toFloat (floor spawn)

        ( probability, seed ) =
            Random.step (Random.float 0 1) context.seed

        nFraction =
            if probability <= fraction then
                1

            else
                0

        n =
            floor spawn + nFraction
    in
    ( ecs, { context | seed = seed } )
        |> Utils.times n Entities.createCollectable

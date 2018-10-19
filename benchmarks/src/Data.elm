module Data exposing
    ( bigEcs
    , bigEcsLabel
    )

import Apis
import Random
import Random.List


bigEcsLabel : String
bigEcsLabel =
    "big ecs (500A 500B 500C 100AB 100AC 100ABC)"


bigEcs : Apis.EcsApi ecs entityId -> ecs
bigEcs api =
    Random.step
        ([ List.repeat 500 (api.createA >> Tuple.first)
         , List.repeat 500 (api.createB >> Tuple.first)
         , List.repeat 500 (api.createC >> Tuple.first)
         , List.repeat 100 (api.createAB >> Tuple.first)
         , List.repeat 100 (api.createAC >> Tuple.first)
         , List.repeat 100 (api.createABC >> Tuple.first)
         ]
            |> List.concat
            |> Random.List.shuffle
        )
        (Random.initialSeed 1234)
        |> Tuple.first
        |> List.foldl (\f ecs -> f ecs) api.empty

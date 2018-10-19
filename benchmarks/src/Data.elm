module Data exposing
    ( initCompareEcs
    , initScaleEcsA
    , initScaleEcsAB
    , initScaleEcsABC
    )

import Apis
import Random
import Random.List


initCompareEcs : Int -> Apis.EcsApi ecs entityId -> ( String, ecs )
initCompareEcs n api =
    ( String.join
        (" " ++ String.fromInt n)
        [ "Ecs", "ABC", "BC", "C" ]
    , applyList
        [ List.repeat n (api.createABC >> Tuple.first)
        , List.repeat n (api.createBC >> Tuple.first)
        , List.repeat n (api.createC >> Tuple.first)
        ]
        api
    )


initScaleEcsA : Int -> Apis.EcsApi ecs entityId -> ( String, ecs )
initScaleEcsA n api =
    ( String.join
        (" " ++ String.fromInt n)
        [ "Ecs", "A", "B", "C", "BC" ]
    , applyList
        [ List.repeat n (api.createA >> Tuple.first)
        , List.repeat n (api.createB >> Tuple.first)
        , List.repeat n (api.createC >> Tuple.first)
        , List.repeat n (api.createBC >> Tuple.first)
        ]
        api
    )


initScaleEcsAB : Int -> Apis.EcsApi ecs entityId -> ( String, ecs )
initScaleEcsAB n api =
    ( String.join
        (" " ++ String.fromInt n)
        [ "Ecs", "AB", "A", "B", "C" ]
    , applyList
        [ List.repeat n (api.createAB >> Tuple.first)
        , List.repeat n (api.createA >> Tuple.first)
        , List.repeat n (api.createB >> Tuple.first)
        , List.repeat n (api.createC >> Tuple.first)
        ]
        api
    )


initScaleEcsABC : Int -> Apis.EcsApi ecs entityId -> ( String, ecs )
initScaleEcsABC n api =
    ( String.join
        (" " ++ String.fromInt n)
        [ "Ecs", "ABC", "A", "B", "C" ]
    , applyList
        [ List.repeat n (api.createABC >> Tuple.first)
        , List.repeat n (api.createA >> Tuple.first)
        , List.repeat n (api.createB >> Tuple.first)
        , List.repeat n (api.createC >> Tuple.first)
        ]
        api
    )


applyList : List (List (ecs -> ecs)) -> Apis.EcsApi ecs entityId -> ecs
applyList list api =
    Random.step
        (list
            |> List.concat
            |> Random.List.shuffle
        )
        (Random.initialSeed 1234)
        |> Tuple.first
        |> List.foldl (\f ecs -> f ecs) api.empty

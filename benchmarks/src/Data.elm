module Data exposing
    ( initCompareEcs
    , initScaleEcsA
    , initScaleEcsAB
    , initScaleEcsABC
    )

import Apis
import Random
import Random.List


initCompareEcs : Int -> Apis.EcsApi ecs -> ( String, ecs )
initCompareEcs n api =
    ( String.join
        (" " ++ String.fromInt n)
        [ "Ecs", "ABC", "BC", "C" ]
    , applyList
        [ List.repeat n api.createABC 
        , List.repeat n api.createBC 
        , List.repeat n api.createC 
        ]
        api
    )


initScaleEcsA : Int -> Apis.EcsApi ecs -> ( String, ecs )
initScaleEcsA n api =
    ( String.join
        (" " ++ String.fromInt n)
        [ "Ecs", "A", "B", "C", "BC" ]
    , applyList
        [ List.repeat n api.createA
        , List.repeat n api.createB
        , List.repeat n api.createC
        , List.repeat n api.createBC
        ]
        api
    )


initScaleEcsAB : Int -> Apis.EcsApi ecs -> ( String, ecs )
initScaleEcsAB n api =
    ( String.join
        (" " ++ String.fromInt n)
        [ "Ecs", "AB", "A", "B", "C" ]
    , applyList
        [ List.repeat n api.createAB
        , List.repeat n api.createA
        , List.repeat n api.createB
        , List.repeat n api.createC
        ]
        api
    )


initScaleEcsABC : Int -> Apis.EcsApi ecs -> ( String, ecs )
initScaleEcsABC n api =
    ( String.join
        (" " ++ String.fromInt n)
        [ "Ecs", "ABC", "A", "B", "C" ]
    , applyList
        [ List.repeat n api.createABC
        , List.repeat n api.createA
        , List.repeat n api.createB
        , List.repeat n api.createC
        ]
        api
    )


applyList : List (List (ecs -> ecs)) -> Apis.EcsApi ecs -> ecs
applyList list api =
    Random.step
        (list
            |> List.concat
            |> Random.List.shuffle
        )
        (Random.initialSeed 1234)
        |> Tuple.first
        |> List.foldl (\f ecs -> f ecs) api.empty

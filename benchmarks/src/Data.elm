module Data exposing
    ( A(..)
    , B(..)
    , Builder
    , C(..)
    , mixed
    , mixedLabel
    )

import Random
import Random.List


type A
    = A


type B
    = B


type C
    = C


type alias Builder ecs entityId =
    { empty : ecs
    , create : ecs -> ( ecs, entityId )
    , insertA : A -> ( ecs, entityId ) -> ( ecs, entityId )
    , insertB : B -> ( ecs, entityId ) -> ( ecs, entityId )
    , insertC : C -> ( ecs, entityId ) -> ( ecs, entityId )
    }


applyList : List (List (ecs -> ( ecs, entityId ))) -> ecs -> ecs
applyList list ecs =
    Random.step
        (list
            |> List.concat
            |> Random.List.shuffle
        )
        (Random.initialSeed 1234)
        |> Tuple.first
        |> List.foldl (\fn ecs2 -> fn ecs2 |> Tuple.first) ecs


mixedLabel : Int -> String
mixedLabel n =
    String.join
        (" " ++ String.fromInt n)
        [ "Ecs", "ABC", "BC", "C" ]


mixed : Int -> Builder ecs entityId -> ecs
mixed n b =
    applyList
        [ List.repeat n (b.create >> b.insertA A >> b.insertB B >> b.insertC C)
        , List.repeat n (b.create >> b.insertB B >> b.insertC C)
        , List.repeat n (b.create >> b.insertC C)
        ]
        b.empty



-- initCompareEcs : Int -> Apis.EcsApi ecs -> ( String, ecs )
-- initCompareEcs n api =
--     ( String.join
--         (" " ++ String.fromInt n)
--         [ "Ecs", "ABC", "BC", "C" ]
--     , applyList
--         [ List.repeat n api.createABC
--         , List.repeat n api.createBC
--         , List.repeat n api.createC
--         ]
--         api
--     )
-- initCompareSubsetEcs : Int -> Apis.EcsApi ecs -> ( String, ecs )
-- initCompareSubsetEcs n api =
--     ( String.join
--         (" " ++ String.fromInt n)
--         [ "Ecs", "AB", "AC", "BC", "ABC" ]
--     , applyList
--         [ List.repeat n api.createAB
--         , List.repeat n api.createAC
--         , List.repeat n api.createBC
--         , List.repeat n api.createABC
--         ]
--         api
--     )
-- initScaleEcsA : Int -> Apis.EcsApi ecs -> ( String, ecs )
-- initScaleEcsA n api =
--     ( String.join
--         (" " ++ String.fromInt n)
--         [ "Ecs", "A", "B", "C", "BC" ]
--     , applyList
--         [ List.repeat n api.createA
--         , List.repeat n api.createB
--         , List.repeat n api.createC
--         , List.repeat n api.createBC
--         ]
--         api
--     )
-- initScaleEcsAB : Int -> Apis.EcsApi ecs -> ( String, ecs )
-- initScaleEcsAB n api =
--     ( String.join
--         (" " ++ String.fromInt n)
--         [ "Ecs", "AB", "A", "B", "C" ]
--     , applyList
--         [ List.repeat n api.createAB
--         , List.repeat n api.createA
--         , List.repeat n api.createB
--         , List.repeat n api.createC
--         ]
--         api
--     )
-- initScaleEcsABC : Int -> Apis.EcsApi ecs -> ( String, ecs )
-- initScaleEcsABC n api =
--     ( String.join
--         (" " ++ String.fromInt n)
--         [ "Ecs", "ABC", "A", "B", "C" ]
--     , applyList
--         [ List.repeat n api.createABC
--         , List.repeat n api.createA
--         , List.repeat n api.createB
--         , List.repeat n api.createC
--         ]
--         api
--     )
-- applyList : List (List (ecs -> ecs)) -> Apis.EcsApi ecs -> ecs
-- applyList list api =
--     Random.step
--         (list
--             |> List.concat
--             |> Random.List.shuffle
--         )
--         (Random.initialSeed 1234)
--         |> Tuple.first
--         |> List.foldl (\f ecs -> f ecs) api.empty

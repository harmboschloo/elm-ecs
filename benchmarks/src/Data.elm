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


type alias Builder world entityId =
    { empty : world
    , create : world -> ( world, entityId )
    , insertA : A -> ( world, entityId ) -> ( world, entityId )
    , insertB : B -> ( world, entityId ) -> ( world, entityId )
    , insertC : C -> ( world, entityId ) -> ( world, entityId )
    }


applyList : List (List (world -> ( world, entityId ))) -> world -> world
applyList list world =
    Random.step
        (list
            |> List.concat
            |> Random.List.shuffle
        )
        (Random.initialSeed 1234)
        |> Tuple.first
        |> List.foldl (\fn ecs2 -> fn ecs2 |> Tuple.first) world


mixedLabel : Int -> String
mixedLabel n =
    String.join
        (" " ++ String.fromInt n)
        [ "Ecs", "ABC", "BC", "C" ]


mixed : Int -> Builder world entityId -> world
mixed n b =
    applyList
        [ List.repeat n (b.create >> b.insertA A >> b.insertB B >> b.insertC C)
        , List.repeat n (b.create >> b.insertB B >> b.insertC C)
        , List.repeat n (b.create >> b.insertC C)
        ]
        b.empty



-- initCompareEcs : Int -> Apis.EcsApi world -> ( String, world )
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
-- initCompareSubsetEcs : Int -> Apis.EcsApi world -> ( String, world )
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
-- initScaleEcsA : Int -> Apis.EcsApi world -> ( String, world )
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
-- initScaleEcsAB : Int -> Apis.EcsApi world -> ( String, world )
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
-- initScaleEcsABC : Int -> Apis.EcsApi world -> ( String, world )
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
-- applyList : List (List (world -> world)) -> Apis.EcsApi world -> world
-- applyList list api =
--     Random.step
--         (list
--             |> List.concat
--             |> Random.List.shuffle
--         )
--         (Random.initialSeed 1234)
--         |> Tuple.first
--         |> List.foldl (\f world -> f world) api.empty

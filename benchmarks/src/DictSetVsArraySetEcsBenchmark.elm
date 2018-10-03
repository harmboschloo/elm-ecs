module DictSetVsArraySetEcsBenchmark exposing (main)

import Array
import ArraySetEcs
import Benchmark exposing (Benchmark)
import Benchmark.Runner exposing (BenchmarkProgram)
import Data
import Dict
import DictSetEcs


iterateEntitiesBenchmark : Benchmark
iterateEntitiesBenchmark =
    let
        init : Data.EcsApi ecs entityId componentType -> ecs
        init api =
            api.empty
                |> Data.times 500 (Data.createEntity api api.a)
                |> Data.times 500 (Data.createEntity api api.b)
                |> Data.times 500 (Data.createEntity api api.c)
                |> Data.times 100 (Data.createEntity2 api api.a api.b)
                |> Data.times 100 (Data.createEntity2 api api.a api.c)
                |> Data.times 100 (Data.createEntity3 api api.a api.b api.c)

        dictSetEcs : DictSetEcs.Ecs
        dictSetEcs =
            init Data.dictSetEcsApi

        arraySetEcs : ArraySetEcs.Ecs
        arraySetEcs =
            init Data.arraySetEcsApi
    in
    Benchmark.describe "500 a, 500 b, 500 c, 100 ab, 100 ac, 100 abc"
        [ Benchmark.compare "iterateEntities a"
            "DictSet"
            (\_ ->
                DictSetEcs.iterateEntitiesWithA
                    (\_ _ x -> x)
                    ( dictSetEcs, () )
            )
            "ArraySet"
            (\_ ->
                ArraySetEcs.iterateEntitiesWithA
                    (\_ _ x -> x)
                    ( arraySetEcs, () )
            )
        , Benchmark.compare "iterateEntities a b"
            "DictSet"
            (\_ ->
                DictSetEcs.iterateEntitiesWithAB
                    (\_ _ _ x -> x)
                    ( dictSetEcs, () )
            )
            "ArraySet"
            (\_ ->
                ArraySetEcs.iterateEntitiesWithAB
                    (\_ _ _ x -> x)
                    ( arraySetEcs, () )
            )
        , Benchmark.compare "iterateEntities a b c"
            "DictSet"
            (\_ ->
                DictSetEcs.iterateEntitiesWithABC
                    (\_ _ _ _ x -> x)
                    ( dictSetEcs, () )
            )
            "ArraySet"
            (\_ ->
                ArraySetEcs.iterateEntitiesWithABC
                    (\_ _ _ _ x -> x)
                    ( arraySetEcs, () )
            )
        ]


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmark.describe "Ecs"
            [ iterateEntitiesBenchmark
            ]
        )

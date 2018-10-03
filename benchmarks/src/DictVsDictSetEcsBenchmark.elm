module DictVsDictSetEcsBenchmark exposing (main)

import Benchmark exposing (Benchmark)
import Benchmark.Runner exposing (BenchmarkProgram)
import Data
import Dict
import DictEcs
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

        dictEcs : DictEcs.Ecs
        dictEcs =
            init Data.dictEcsApi

        dictSetEcs : DictSetEcs.Ecs
        dictSetEcs =
            init Data.dictSetEcsApi
    in
    Benchmark.describe "500 a, 500 b, 500 c, 100 ab, 100 ac, 100 abc"
        [ Benchmark.compare "iterateEntities a"
            "Dict"
            (\_ ->
                DictEcs.iterateEntities
                    DictEcs.a
                    (\_ _ x -> x)
                    ( dictEcs, () )
            )
            "DictSet"
            (\_ ->
                DictSetEcs.iterateEntitiesWithA
                    (\_ _ x -> x)
                    ( dictSetEcs, () )
            )
        , Benchmark.compare "iterateEntities a b"
            "Dict"
            (\_ ->
                DictEcs.iterateEntities2
                    DictEcs.a
                    DictEcs.b
                    (\_ _ _ x -> x)
                    ( dictEcs, () )
            )
            "DictSet"
            (\_ ->
                DictSetEcs.iterateEntitiesWithAB
                    (\_ _ _ x -> x)
                    ( dictSetEcs, () )
            )
        , Benchmark.compare "iterateEntities a b c"
            "Dict"
            (\_ ->
                DictEcs.iterateEntities3
                    DictEcs.a
                    DictEcs.b
                    DictEcs.c
                    (\_ _ _ _ x -> x)
                    ( dictEcs, () )
            )
            "DictSet"
            (\_ ->
                DictSetEcs.iterateEntitiesWithABC
                    (\_ _ _ _ x -> x)
                    ( dictSetEcs, () )
            )
        ]


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmark.describe "Ecs"
            [ iterateEntitiesBenchmark
            ]
        )

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
        dictEcs : DictEcs.Ecs
        dictEcs =
            Data.initCompareIterateEntities Data.dictEcsApi

        dictSetEcs : DictSetEcs.Ecs
        dictSetEcs =
            Data.initCompareIterateEntities Data.dictSetEcsApi
    in
    Benchmark.describe Data.initCompareIterateEntitiesLabel
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

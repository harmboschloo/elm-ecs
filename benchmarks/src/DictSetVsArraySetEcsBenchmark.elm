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
        dictSetEcs : DictSetEcs.Ecs
        dictSetEcs =
            Data.initCompareIterateEntities Data.dictSetEcsApi

        arraySetEcs : ArraySetEcs.Ecs
        arraySetEcs =
            Data.initCompareIterateEntities Data.arraySetEcsApi
    in
    Benchmark.describe Data.initCompareIterateEntitiesLabel
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

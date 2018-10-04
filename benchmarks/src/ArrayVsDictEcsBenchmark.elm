module ArrayVsDictEcsBenchmark exposing (main)

import Array
import ArrayEcs
import Benchmark exposing (Benchmark)
import Benchmark.Runner exposing (BenchmarkProgram)
import Data
import Dict
import DictEcs


iterateEntitiesBenchmark : Benchmark
iterateEntitiesBenchmark =
    let
        arrayEcs : ArrayEcs.Ecs
        arrayEcs =
            Data.initCompareIterateEntities Data.arrayEcsApi

        dictEcs : DictEcs.Ecs
        dictEcs =
            Data.initCompareIterateEntities Data.dictEcsApi
    in
    Benchmark.describe Data.initCompareIterateEntitiesLabel
        [ Benchmark.compare "iterateEntities a"
            "Array"
            (\_ ->
                ArrayEcs.iterateEntities
                    ArrayEcs.a
                    (\_ _ x -> x)
                    ( arrayEcs, () )
            )
            "Dict"
            (\_ ->
                DictEcs.iterateEntities
                    DictEcs.a
                    (\_ _ x -> x)
                    ( dictEcs, () )
            )
        , Benchmark.compare "iterateEntities2 a b"
            "Array"
            (\_ ->
                ArrayEcs.iterateEntities2
                    ArrayEcs.a
                    ArrayEcs.b
                    (\_ _ _ x -> x)
                    ( arrayEcs, () )
            )
            "Dict"
            (\_ ->
                DictEcs.iterateEntities2
                    DictEcs.a
                    DictEcs.b
                    (\_ _ _ x -> x)
                    ( dictEcs, () )
            )
        , Benchmark.compare "iterateEntities3 a b c"
            "Array"
            (\_ ->
                ArrayEcs.iterateEntities3
                    ArrayEcs.a
                    ArrayEcs.b
                    ArrayEcs.c
                    (\_ _ _ _ x -> x)
                    ( arrayEcs, () )
            )
            "Dict"
            (\_ ->
                DictEcs.iterateEntities3
                    DictEcs.a
                    DictEcs.b
                    DictEcs.c
                    (\_ _ _ _ x -> x)
                    ( dictEcs, () )
            )
        ]


foldlBenchmark : Benchmark
foldlBenchmark =
    let
        array =
            Array.repeat 1000 ()

        dict =
            Dict.fromList (List.map (\id -> ( id, () )) (List.range 0 999))
    in
    Benchmark.describe "1000 elements"
        [ Benchmark.compare "foldl"
            "Array"
            (\_ ->
                Array.foldl
                    (\a ( id, b ) -> ( id + 1, b ))
                    ( 0, () )
                    array
            )
            "Dict"
            (\_ ->
                Dict.foldl
                    (\id a b -> b)
                    ()
                    dict
            )
        ]


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmark.describe "Ecs"
            [ iterateEntitiesBenchmark

            -- , foldlBenchmark
            ]
        )

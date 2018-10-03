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
        init : Data.EcsApi ecs entityId componentType -> ecs
        init api =
            api.empty
                |> Data.times 500 (Data.createEntity api api.a)
                |> Data.times 500 (Data.createEntity api api.b)
                |> Data.times 500 (Data.createEntity api api.c)
                |> Data.times 100 (Data.createEntity2 api api.a api.b)
                |> Data.times 100 (Data.createEntity2 api api.a api.c)
                |> Data.times 100 (Data.createEntity3 api api.a api.b api.c)

        arrayEcs : ArrayEcs.Ecs
        arrayEcs =
            init Data.arrayEcsApi

        dictEcs : DictEcs.Ecs
        dictEcs =
            init Data.dictEcsApi
    in
    Benchmark.describe "500 a, 500 b, 500 c, 100 ab, 100 ac, 100 abc"
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
        , Benchmark.compare "iterateEntities2 a c"
            "Array"
            (\_ ->
                ArrayEcs.iterateEntities2
                    ArrayEcs.a
                    ArrayEcs.c
                    (\_ _ _ x -> x)
                    ( arrayEcs, () )
            )
            "Dict"
            (\_ ->
                DictEcs.iterateEntities2
                    DictEcs.a
                    DictEcs.c
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

module Benchmarks exposing (compareFoldl, compareIterate)

import Apis
import Array
import Benchmark exposing (Benchmark)
import Benchmark.Runner exposing (BenchmarkProgram)
import Data
import Dict


compareIterate : Apis.EcsApi a1 a2 -> Apis.EcsApi b1 b2 -> Benchmark
compareIterate apiA apiB =
    let
        ecsA =
            Data.bigEcs apiA

        ecsB =
            Data.bigEcs apiB
    in
    Benchmark.describe Data.bigEcsLabel
        [ Benchmark.compare "iterateA"
            apiA.label
            (\_ -> apiA.iterateA ecsA)
            apiB.label
            (\_ -> apiB.iterateA ecsB)
        , Benchmark.compare "iterateAB"
            apiA.label
            (\_ -> apiA.iterateAB ecsA)
            apiB.label
            (\_ -> apiB.iterateAB ecsB)
        , Benchmark.compare "iterateABC"
            apiA.label
            (\_ -> apiA.iterateABC ecsA)
            apiB.label
            (\_ -> apiB.iterateABC ecsB)
        ]


compareFoldl : Benchmark
compareFoldl =
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

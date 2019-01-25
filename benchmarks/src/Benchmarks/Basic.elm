module Benchmarks.Basic exposing (main)

import Benchmark exposing (Benchmark)
import Benchmark.Runner as Runner
import Data
import Ecs1
import Ecs2


ecs1Label : String
ecs1Label =
    "Ecs v1"


ecs2Label : String
ecs2Label =
    "Ecs v2"


main : Runner.BenchmarkProgram
main =
    Runner.program (benchmark 20)


benchmark : Int -> Benchmark
benchmark n =
    let
        label =
            Data.mixedLabel n

        ecs1 =
            Data.mixed n Ecs1.builder

        ecs2 =
            Data.mixed n Ecs2.builder

        ( insertEcs1, insertEntityId1 ) =
            Ecs1.builder.create ecs1

        ( insertEcs2, insertEntityId2 ) =
            Ecs2.builder.create ecs2
    in
    Benchmark.describe label
        [ Benchmark.compare "insert A"
            ecs1Label
            (\_ -> Ecs1.insertA insertEntityId1 Data.A insertEcs1)
            ecs2Label
            (\_ -> Ecs2.insertA insertEntityId2 Data.A insertEcs2)
        , Benchmark.compare "insert B"
            ecs1Label
            (\_ -> Ecs1.insertB insertEntityId1 Data.B insertEcs1)
            ecs2Label
            (\_ -> Ecs2.insertB insertEntityId2 Data.B insertEcs2)
        , Benchmark.compare "insert C"
            ecs1Label
            (\_ -> Ecs1.insertC insertEntityId1 Data.C insertEcs1)
            ecs2Label
            (\_ -> Ecs2.insertC insertEntityId2 Data.C insertEcs2)
        , Benchmark.compare "selectA"
            ecs1Label
            (\_ -> Ecs1.selectA ecs1)
            ecs2Label
            (\_ -> Ecs2.selectA ecs2)
        , Benchmark.compare "selectB"
            ecs1Label
            (\_ -> Ecs1.selectB ecs1)
            ecs2Label
            (\_ -> Ecs2.selectB ecs2)
        , Benchmark.compare "selectC"
            ecs1Label
            (\_ -> Ecs1.selectC ecs1)
            ecs2Label
            (\_ -> Ecs2.selectC ecs2)
        , Benchmark.compare "selectAB"
            ecs1Label
            (\_ -> Ecs1.selectAB ecs1)
            ecs2Label
            (\_ -> Ecs2.selectAB ecs2)
        , Benchmark.compare "selectBA"
            ecs1Label
            (\_ -> Ecs1.selectBA ecs1)
            ecs2Label
            (\_ -> Ecs2.selectBA ecs2)
        , Benchmark.compare "selectABC"
            ecs1Label
            (\_ -> Ecs1.selectABC ecs1)
            ecs2Label
            (\_ -> Ecs2.selectABC ecs2)
        , Benchmark.compare "selectCBA"
            ecs1Label
            (\_ -> Ecs1.selectCBA ecs1)
            ecs2Label
            (\_ -> Ecs2.selectCBA ecs2)
        ]

module Benchmarks.Basic exposing (main)

import Benchmark exposing (Benchmark)
import Benchmark.Runner as Runner
import Data
import EcsV2d_Comparable as Ecs1
import EcsV2e_EntityOperation as Ecs2


main : Runner.BenchmarkProgram
main =
    Runner.program (benchmark 20)


benchmark : Int -> Benchmark
benchmark n =
    let
        label =
            Data.mixedLabel n

        world1 =
            Data.mixed n Ecs1.builder

        world2 =
            Data.mixed n Ecs2.builder

        ( insertWorld1, insertEntityId1 ) =
            Ecs1.builder.create world1

        ( insertWorld2, insertEntityId2 ) =
            Ecs2.builder.create world2
    in
    Benchmark.describe label
        [ Benchmark.compare "insert A"
            Ecs1.label
            (\_ -> Ecs1.insertA insertEntityId1 Data.A insertWorld1)
            Ecs2.label
            (\_ -> Ecs2.insertA insertEntityId2 Data.A insertWorld2)
        , Benchmark.compare "insert B"
            Ecs1.label
            (\_ -> Ecs1.insertB insertEntityId1 Data.B insertWorld1)
            Ecs2.label
            (\_ -> Ecs2.insertB insertEntityId2 Data.B insertWorld2)
        , Benchmark.compare "insert C"
            Ecs1.label
            (\_ -> Ecs1.insertC insertEntityId1 Data.C insertWorld1)
            Ecs2.label
            (\_ -> Ecs2.insertC insertEntityId2 Data.C insertWorld2)
        , Benchmark.compare "selectA"
            Ecs1.label
            (\_ -> Ecs1.selectA world1)
            Ecs2.label
            (\_ -> Ecs2.selectA world2)
        , Benchmark.compare "selectB"
            Ecs1.label
            (\_ -> Ecs1.selectB world1)
            Ecs2.label
            (\_ -> Ecs2.selectB world2)
        , Benchmark.compare "selectC"
            Ecs1.label
            (\_ -> Ecs1.selectC world1)
            Ecs2.label
            (\_ -> Ecs2.selectC world2)
        , Benchmark.compare "selectAB"
            Ecs1.label
            (\_ -> Ecs1.selectAB world1)
            Ecs2.label
            (\_ -> Ecs2.selectAB world2)
        , Benchmark.compare "selectBA"
            Ecs1.label
            (\_ -> Ecs1.selectBA world1)
            Ecs2.label
            (\_ -> Ecs2.selectBA world2)
        , Benchmark.compare "selectABC"
            Ecs1.label
            (\_ -> Ecs1.selectABC world1)
            Ecs2.label
            (\_ -> Ecs2.selectABC world2)
        , Benchmark.compare "selectCBA"
            Ecs1.label
            (\_ -> Ecs1.selectCBA world1)
            Ecs2.label
            (\_ -> Ecs2.selectCBA world2)
        ]

module Benchmarks.EntityOperations exposing (main)

import Benchmark exposing (Benchmark)
import Benchmark.Runner as Runner
import Data
import EcsV2e_EntityOperation as Ecs


main : Runner.BenchmarkProgram
main =
    Runner.program (benchmark 20)


benchmark : Int -> Benchmark
benchmark n =
    let
        label =
            Data.mixedLabel n

        world =
            Data.mixed n Ecs.builder
    in
    Benchmark.describe label
        [ Benchmark.compare "fold A > insert A"
            "plain"
            (\_ -> Ecs.foldA (\id a w -> Ecs.insertA id Data.A w) world)
            "EntityOperation"
            (\_ -> Ecs.entityOperationFoldA (\a entityOperation -> Ecs.entityOperationInsertA Data.A entityOperation) world)
        , Benchmark.compare "fold ABC > insert A"
            "plain"
            (\_ -> Ecs.foldABC (\id a b c w -> Ecs.insertA id Data.A w) world)
            "EntityOperation"
            (\_ -> Ecs.entityOperationFoldABC (\a b c entityOperation -> Ecs.entityOperationInsertA Data.A entityOperation) world)
        ]

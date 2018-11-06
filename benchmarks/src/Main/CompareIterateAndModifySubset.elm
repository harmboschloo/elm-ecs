module Main.CompareIterateAndModifySubset exposing (main)

import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks
import Config


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareIterateAndModifySubset 20 Config.ecsA Config.ecsB)

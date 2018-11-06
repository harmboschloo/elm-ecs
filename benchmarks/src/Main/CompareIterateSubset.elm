module Main.CompareIterateSubset exposing (main)

import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks
import Config


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareIterateSubset 20 Config.ecsA Config.ecsB)

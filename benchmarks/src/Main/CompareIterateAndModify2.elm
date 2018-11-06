module Main.CompareIterateAndModify2 exposing (main)

import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks
import Config


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareIterateAndModify2 20 Config.ecsA Config.ecsB)

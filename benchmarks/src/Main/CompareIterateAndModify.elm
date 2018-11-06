module Main.CompareIterateAndModify exposing (main)

import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks
import Config


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareIterateAndModify 20 Config.ecsA Config.ecsB)

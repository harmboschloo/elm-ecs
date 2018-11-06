module Main.CompareIterate exposing (main)

import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks
import Config


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareIterate 20 Config.ecsA Config.ecsB)

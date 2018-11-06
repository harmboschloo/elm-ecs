module Main.CompareIterateBig exposing (main)

import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks
import Config


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareIterate 200 Config.ecsA Config.ecsB)

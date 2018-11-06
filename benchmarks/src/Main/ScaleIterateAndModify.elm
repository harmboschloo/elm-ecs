module Main.ScaleIterateAndModify exposing (main)

import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks
import Config


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.scaleIterateAndModify 20 Config.ecsA Config.ecsB)
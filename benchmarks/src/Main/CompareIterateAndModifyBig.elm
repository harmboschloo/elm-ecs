module Main.CompareIterateAndModifyBig exposing (main)

import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks
import Config


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareIterateAndModify 200 Config.ecsA Config.ecsB)

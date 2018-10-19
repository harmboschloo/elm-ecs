module ScaleIterateAndModify2 exposing (main)

import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks
import Config


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.scaleIterateAndModify2 20 Config.ecsA Config.ecsB)

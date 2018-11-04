module CompareUpdateXBig exposing (main)

import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks
import Config


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareUpdateX 200 Config.ecsA Config.ecsB)

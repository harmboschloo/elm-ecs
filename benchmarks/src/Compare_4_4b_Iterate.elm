module Compare_4_4b_Iterate exposing (main)

import Apis
import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareIterate Apis.ecs4 Apis.ecs4b)

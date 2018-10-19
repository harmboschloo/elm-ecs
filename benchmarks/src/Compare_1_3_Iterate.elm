module Compare_1_3_Iterate exposing (main)

import Apis
import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareIterate Apis.ecs1 Apis.ecs3)

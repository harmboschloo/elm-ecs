module Compare_3_4_Iterate exposing (main)

import Apis
import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareIterate Apis.ecs3 Apis.ecs4)

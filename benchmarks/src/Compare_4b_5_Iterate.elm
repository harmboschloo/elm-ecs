module Compare_4b_5_Iterate exposing (main)

import Apis
import Benchmark.Runner exposing (BenchmarkProgram)
import Benchmarks


main : BenchmarkProgram
main =
    Benchmark.Runner.program
        (Benchmarks.compareIterate Apis.ecs4b Apis.ecs5)

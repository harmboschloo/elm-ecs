module Benchmarks exposing
    ( compareFoldl
    , compareIterate
    , compareIterateAndModify
    , compareIterateAndModify2
    , scaleIterate
    , scaleIterateAndModify
    , scaleIterateAndModify2
    )

import Apis
import Array
import Benchmark exposing (Benchmark)
import Benchmark.Runner exposing (BenchmarkProgram)
import Data
import Dict


compareIterate : Int -> Apis.EcsApi a -> Apis.EcsApi b -> Benchmark
compareIterate n apiA apiB =
    let
        ( label, ecsA ) =
            Data.initCompareEcs n apiA

        ( _, ecsB ) =
            Data.initCompareEcs n apiB
    in
    Benchmark.describe label
        [ Benchmark.compare "iterateA"
            apiA.label
            (\_ -> apiA.iterateA ecsA)
            apiB.label
            (\_ -> apiB.iterateA ecsB)
        , Benchmark.compare "iterateAB"
            apiA.label
            (\_ -> apiA.iterateAB ecsA)
            apiB.label
            (\_ -> apiB.iterateAB ecsB)
        , Benchmark.compare "iterateABC"
            apiA.label
            (\_ -> apiA.iterateABC ecsA)
            apiB.label
            (\_ -> apiB.iterateABC ecsB)
        ]


compareIterateAndModify : Int -> Apis.EcsApi a -> Apis.EcsApi b -> Benchmark
compareIterateAndModify n apiA apiB =
    let
        ( label, ecsA ) =
            Data.initCompareEcs n apiA

        ( _, ecsB ) =
            Data.initCompareEcs n apiB
    in
    Benchmark.describe label
        [ Benchmark.compare "iterateAModifyA"
            apiA.label
            (\_ -> apiA.iterateAModifyA ecsA)
            apiB.label
            (\_ -> apiB.iterateAModifyA ecsB)
        , Benchmark.compare "iterateABModifyA"
            apiA.label
            (\_ -> apiA.iterateABModifyA ecsA)
            apiB.label
            (\_ -> apiB.iterateABModifyA ecsB)
        , Benchmark.compare "iterateABCModifyA"
            apiA.label
            (\_ -> apiA.iterateABCModifyA ecsA)
            apiB.label
            (\_ -> apiB.iterateABCModifyA ecsB)
        ]


compareIterateAndModify2 : Int -> Apis.EcsApi a -> Apis.EcsApi b -> Benchmark
compareIterateAndModify2 n apiA apiB =
    let
        ( label, ecsA ) =
            Data.initCompareEcs n apiA

        ( _, ecsB ) =
            Data.initCompareEcs n apiB
    in
    Benchmark.describe label
        [ Benchmark.compare "iterateAModifyA"
            apiA.label
            (\_ -> apiA.iterateAModifyA ecsA)
            apiB.label
            (\_ -> apiB.iterateAModifyA ecsB)
        , Benchmark.compare "iterateAModifyAB"
            apiA.label
            (\_ -> apiA.iterateAModifyAB ecsA)
            apiB.label
            (\_ -> apiB.iterateAModifyAB ecsB)
        , Benchmark.compare "iterateAModifyABC"
            apiA.label
            (\_ -> apiA.iterateAModifyABC ecsA)
            apiB.label
            (\_ -> apiB.iterateAModifyABC ecsB)
        ]


scaleIterate : Int -> Apis.EcsApi a -> Apis.EcsApi b -> Benchmark
scaleIterate n apiA apiB =
    let
        ( labelA_A, ecsA_A ) =
            Data.initScaleEcsA n apiA

        ( labelA_AB, ecsA_AB ) =
            Data.initScaleEcsAB n apiA

        ( labelA_ABC, ecsA_ABC ) =
            Data.initScaleEcsABC n apiA

        ( labelB_A, ecsB_A ) =
            Data.initScaleEcsA n apiB

        ( labelB_AB, ecsB_AB ) =
            Data.initScaleEcsAB n apiB

        ( labelB_ABC, ecsB_ABC ) =
            Data.initScaleEcsABC n apiB
    in
    Benchmark.describe "iterate"
        [ Benchmark.scale apiA.label
            [ ( "A / " ++ labelA_A, \_ -> apiA.iterateA ecsA_A )
            , ( "AB / " ++ labelA_AB, \_ -> apiA.iterateAB ecsA_AB )
            , ( "ABC / " ++ labelA_ABC, \_ -> apiA.iterateABC ecsA_ABC )
            ]
        , Benchmark.scale apiB.label
            [ ( "A / " ++ labelB_A, \_ -> apiB.iterateA ecsB_A )
            , ( "AB / " ++ labelB_AB, \_ -> apiB.iterateAB ecsB_AB )
            , ( "ABC / " ++ labelB_ABC, \_ -> apiB.iterateABC ecsB_ABC )
            ]
        ]


scaleIterateAndModify : Int -> Apis.EcsApi a -> Apis.EcsApi b -> Benchmark
scaleIterateAndModify n apiA apiB =
    let
        ( labelA_A, ecsA_A ) =
            Data.initScaleEcsA n apiA

        ( labelA_AB, ecsA_AB ) =
            Data.initScaleEcsAB n apiA

        ( labelA_ABC, ecsA_ABC ) =
            Data.initScaleEcsABC n apiA

        ( labelB_A, ecsB_A ) =
            Data.initScaleEcsA n apiB

        ( labelB_AB, ecsB_AB ) =
            Data.initScaleEcsAB n apiB

        ( labelB_ABC, ecsB_ABC ) =
            Data.initScaleEcsABC n apiB
    in
    Benchmark.describe "iterateXModifyA"
        [ Benchmark.scale apiA.label
            [ ( "A / " ++ labelA_A, \_ -> apiA.iterateAModifyA ecsA_A )
            , ( "AB / " ++ labelA_AB, \_ -> apiA.iterateABModifyA ecsA_AB )
            , ( "ABC / " ++ labelA_ABC, \_ -> apiA.iterateABCModifyA ecsA_ABC )
            ]
        , Benchmark.scale apiB.label
            [ ( "A / " ++ labelB_A, \_ -> apiB.iterateAModifyA ecsB_A )
            , ( "AB / " ++ labelB_AB, \_ -> apiB.iterateABModifyA ecsB_AB )
            , ( "ABC / " ++ labelB_ABC, \_ -> apiB.iterateABCModifyA ecsB_ABC )
            ]
        ]


scaleIterateAndModify2 : Int -> Apis.EcsApi a -> Apis.EcsApi b -> Benchmark
scaleIterateAndModify2 n apiA apiB =
    let
        ( labelA_A, ecsA_A ) =
            Data.initScaleEcsA n apiA

        ( labelA_AB, ecsA_AB ) =
            Data.initScaleEcsAB n apiA

        ( labelA_ABC, ecsA_ABC ) =
            Data.initScaleEcsABC n apiA

        ( labelB_A, ecsB_A ) =
            Data.initScaleEcsA n apiB

        ( labelB_AB, ecsB_AB ) =
            Data.initScaleEcsAB n apiB

        ( labelB_ABC, ecsB_ABC ) =
            Data.initScaleEcsABC n apiB
    in
    Benchmark.describe "iterateAModifyX"
        [ Benchmark.scale apiA.label
            [ ( "A / " ++ labelA_A, \_ -> apiA.iterateAModifyA ecsA_A )
            , ( "AB / " ++ labelA_AB, \_ -> apiA.iterateAModifyAB ecsA_AB )
            , ( "ABC / " ++ labelA_ABC, \_ -> apiA.iterateAModifyABC ecsA_ABC )
            ]
        , Benchmark.scale apiB.label
            [ ( "A / " ++ labelB_A, \_ -> apiB.iterateAModifyA ecsB_A )
            , ( "AB / " ++ labelB_AB, \_ -> apiB.iterateAModifyAB ecsB_AB )
            , ( "ABC / " ++ labelB_ABC, \_ -> apiB.iterateAModifyABC ecsB_ABC )
            ]
        ]


compareFoldl : Benchmark
compareFoldl =
    let
        array =
            Array.repeat 1000 ()

        dict =
            Dict.fromList (List.map (\id -> ( id, () )) (List.range 0 999))
    in
    Benchmark.describe "1000 elements"
        [ Benchmark.compare "foldl"
            "Array"
            (\_ ->
                Array.foldl
                    (\a ( id, b ) -> ( id + 1, b ))
                    ( 0, () )
                    array
            )
            "Dict"
            (\_ ->
                Dict.foldl
                    (\id a b -> b)
                    ()
                    dict
            )
        ]

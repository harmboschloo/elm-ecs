module Tests exposing (suite)

import EcsGenerator
    exposing
        ( Component
        , Ecs
        , component
        , ecs
        )
import Expect exposing (Expectation)
import Test exposing (Test)


testEcs : Ecs
testEcs =
    ecs "Test.Ecs" "Ecs"


a : Component
a =
    component "Components" "A"


b : Component
b =
    component "Components" "B"


suite : Test
suite =
    Test.describe "Ecs Generator"
        [ Test.test "generate ok"
            (\_ ->
                EcsGenerator.generate
                    { ecs = testEcs
                    , components = [ a ]
                    }
                    |> Expect.ok
            )
        , Test.describe "generate err"
            [ Test.test "invalid ecs module name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = ecs "Test Ecs" "Ecs"
                        , components = [ a ]
                        }
                        |> Expect.err
                )
            , Test.test "invalid ecs type name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = ecs "Test.Ecs" "ecs"
                        , components = [ a ]
                        }
                        |> Expect.err
                )
            , Test.test "components empty"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = []
                        }
                        |> Expect.err
                )
            , Test.test "invalid component module name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ component "components" "A" ]
                        }
                        |> Expect.err
                )
            , Test.test "invalid component type name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ component "Components" "a" ]
                        }
                        |> Expect.err
                )
            , Test.test "duplicate component"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a, a ]
                        }
                        |> Expect.err
                )
            ]
        ]

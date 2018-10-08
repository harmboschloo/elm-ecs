module Tests exposing (suite)

import EcsGenerator
    exposing
        ( Component
        , Ecs
        , Iterator
        , component
        , ecs
        , iterator
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
                    , iterators = [ iterator "a" [ a ] ]
                    }
                    |> Expect.ok
            )
        , Test.describe "generate err"
            [ Test.test "invalid ecs module name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = ecs "Test Ecs" "Ecs"
                        , components = [ a ]
                        , iterators = [ iterator "a" [ a ] ]
                        }
                        |> Expect.err
                )
            , Test.test "invalid ecs type name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = ecs "Test.Ecs" "ecs"
                        , components = [ a ]
                        , iterators = [ iterator "a" [ a ] ]
                        }
                        |> Expect.err
                )
            , Test.test "components empty"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = []
                        , iterators = []
                        }
                        |> Expect.err
                )
            , Test.test "invalid component module name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ component "components" "A" ]
                        , iterators = [ iterator "a" [ component "components" "A" ] ]
                        }
                        |> Expect.err
                )
            , Test.test "invalid component type name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ component "Components" "a" ]
                        , iterators = [ iterator "a" [ component "Components" "a" ] ]
                        }
                        |> Expect.err
                )
            , Test.test "duplicate component"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a, a ]
                        , iterators = [ iterator "a" [ a ] ]
                        }
                        |> Expect.err
                )
            , Test.test "iterators empty"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a ]
                        , iterators = []
                        }
                        |> Expect.err
                )
            , Test.test "iterator name invalid"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a ]
                        , iterators = [ iterator "a a" [ a ] ]
                        }
                        |> Expect.err
                )
            , Test.test "iterator components empty"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a ]
                        , iterators = [ iterator "a" [] ]
                        }
                        |> Expect.err
                )
            , Test.test "unkonwn iterator component"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a ]
                        , iterators = [ iterator "b" [ b ] ]
                        }
                        |> Expect.err
                )
            , Test.test "duplicate iterator component"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a ]
                        , iterators = [ iterator "a" [ a, a ] ]
                        }
                        |> Expect.err
                )
            ]
        ]

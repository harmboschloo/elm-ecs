module Tests exposing (suite)

import EcsGenerator
    exposing
        ( Component
        , Ecs
        , component
        , ecs
        , node
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
                    , nodes = [ node "a" [ a ] ]
                    }
                    |> Expect.ok
            )
        , Test.describe "generate err"
            [ Test.test "invalid ecs module name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = ecs "Test Ecs" "Ecs"
                        , components = [ a ]
                        , nodes = [ node "a" [ a ] ]
                        }
                        |> Expect.err
                )
            , Test.test "invalid ecs type name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = ecs "Test.Ecs" "ecs"
                        , components = [ a ]
                        , nodes = [ node "a" [ a ] ]
                        }
                        |> Expect.err
                )
            , Test.test "components empty"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = []
                        , nodes = []
                        }
                        |> Expect.err
                )
            , Test.test "invalid component module name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ component "components" "A" ]
                        , nodes = [ node "a" [ component "components" "A" ] ]
                        }
                        |> Expect.err
                )
            , Test.test "invalid component type name"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ component "Components" "a" ]
                        , nodes = [ node "a" [ component "Components" "a" ] ]
                        }
                        |> Expect.err
                )
            , Test.test "duplicate component"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a, a ]
                        , nodes = [ node "a" [ a ] ]
                        }
                        |> Expect.err
                )
            , Test.test "nodes empty"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a ]
                        , nodes = []
                        }
                        |> Expect.err
                )
            , Test.test "node name invalid"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a ]
                        , nodes = [ node "a a" [ a ] ]
                        }
                        |> Expect.err
                )
            , Test.test "node components empty"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a ]
                        , nodes = [ node "a" [] ]
                        }
                        |> Expect.err
                )
            , Test.test "unkonwn node component"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a ]
                        , nodes = [ node "b" [ b ] ]
                        }
                        |> Expect.err
                )
            , Test.test "duplicate node component"
                (\_ ->
                    EcsGenerator.generate
                        { ecs = testEcs
                        , components = [ a ]
                        , nodes = [ node "a" [ a, a ] ]
                        }
                        |> Expect.err
                )
            ]
        ]

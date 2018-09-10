module EcsGenerator.Config exposing (config)

import EcsGenerator exposing (Config, addComponent, init)


config : Config
config =
    init "Ecs"
        |> addComponent "Acceleration" "Ecs.Components"
        |> addComponent "Ai" "Ecs.Components"
        |> addComponent "Controls" "Ecs.Components"
        |> addComponent "Display" "Ecs.Components"
        |> addComponent "Human" "Ecs.Components"
        |> addComponent "Position" "Ecs.Components"
        |> addComponent "Predator" "Ecs.Components"
        |> addComponent "Prey" "Ecs.Components"
        |> addComponent "Velocity" "Ecs.Components"

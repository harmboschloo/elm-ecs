module EcsGenerator.Config exposing (config)

import EcsGenerator exposing (Config, addComponent, init)


config : Config
config =
    init "Ecs"
        |> addComponent "Ai" "Ecs.Components"
        |> addComponent "Controls" "Ecs.Components"
        |> addComponent "KeyControlsMap" "Ecs.Components"
        |> addComponent "Position" "Ecs.Components"
        |> addComponent "Predator" "Ecs.Components"
        |> addComponent "Prey" "Ecs.Components"
        |> addComponent "Motion" "Ecs.Components"
        |> addComponent "Sprite" "Ecs.Components"
        |> addComponent "Velocity" "Ecs.Components"

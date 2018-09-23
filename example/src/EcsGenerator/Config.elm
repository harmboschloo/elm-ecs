module EcsGenerator.Config exposing (config)

import EcsGenerator exposing (Config, addComponent, init)


config : Config
config =
    init "Ecs"
        |> addComponent "Ecs.Components" "Ai"
        |> addComponent "Ecs.Components" "Collectable"
        |> addComponent "Ecs.Components" "Collector"
        |> addComponent "Ecs.Components" "Controls"
        |> addComponent "Ecs.Components" "KeyControlsMap"
        |> addComponent "Ecs.Components" "Position"
        |> addComponent "Ecs.Components" "Motion"
        |> addComponent "Ecs.Components" "Sprite"
        |> addComponent "Ecs.Components" "Velocity"

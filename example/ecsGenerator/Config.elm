module Config exposing (config)

import EcsGenerator exposing (Config, addComponent, init)


config : Config
config =
    init "Ecs"
        |> addComponent "Components" "Ai"
        |> addComponent "Components" "Collectable"
        |> addComponent "Components" "Collector"
        |> addComponent "Components" "Destroy"
        |> addComponent "Components" "KeyControlsMap"
        |> addComponent "Components" "Position"
        |> addComponent "Components" "Motion"
        |> addComponent "Components" "Scale"
        |> addComponent "Components" "ScaleAnimation"
        |> addComponent "Components" "Sprite"
        |> addComponent "Components" "Velocity"
        |> addComponent "Components.Controls" "Controls"

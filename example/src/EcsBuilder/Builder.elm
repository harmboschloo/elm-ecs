port module EcsBuilder.Builder exposing (main)

import EcsModule1 exposing (Builder, Config, addComponent, builder, init)


config : Config
config =
    init "Ecs"
        |> addComponent "Position" "Ecs.Components"
        |> addComponent "Velocity" "Ecs.Components"
        |> addComponent "Display" "Ecs.Components"


port onResult : String -> Cmd msg


main : Builder msg
main =
    builder onResult config

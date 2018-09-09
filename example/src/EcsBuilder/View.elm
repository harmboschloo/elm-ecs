module EcsBuilder.BuilderView exposing (main)

import EcsModule1 exposing (addComponent, build, init)
import Html exposing (Html, code, text)
import Html.Attributes exposing (style)


main : Html msg
main =
    code [ style "white-space" "pre" ]
        [ init "Ecs"
            |> addComponent "Acceleration" "Ecs.Components"
            |> addComponent "Ai" "Ecs.Components"
            |> addComponent "Controls" "Ecs.Components"
            |> addComponent "Display" "Ecs.Components"
            |> addComponent "Human" "Ecs.Components"
            |> addComponent "Position" "Ecs.Components"
            |> addComponent "Predator" "Ecs.Components"
            |> addComponent "Prey" "Ecs.Components"
            |> addComponent "Velocity" "Ecs.Components"
            |> build
            |> text
        ]

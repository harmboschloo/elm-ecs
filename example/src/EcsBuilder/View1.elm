module EcsBuilder.BuilderView exposing (main)

import EcsModule1 exposing (addComponent, build, init)
import Html exposing (Html, code, text)
import Html.Attributes exposing (style)


main : Html msg
main =
    code [ style "white-space" "pre" ]
        [ init "Ecs1"
            |> addComponent "Position" "Ecs.Components"
            |> addComponent "Velocity" "Ecs.Components"
            |> addComponent "Display" "Ecs.Components"
            |> build
            |> text
        ]

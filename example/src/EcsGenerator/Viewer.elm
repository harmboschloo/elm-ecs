module EcsGenerator.Viewer exposing (main)

import EcsGenerator exposing (generate)
import EcsGenerator.Config exposing (config)
import Html exposing (Html, code, text)
import Html.Attributes exposing (style)


main : Html msg
main =
    code
        [ style "white-space" "pre" ]
        [ text (generate config) ]

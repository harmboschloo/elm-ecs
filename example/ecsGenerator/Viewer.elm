module Viewer exposing (main)

import Config exposing (config)
import EcsGenerator exposing (generate)
import Html exposing (Html, code, text)
import Html.Attributes exposing (style)


main : Html msg
main =
    code
        [ style "white-space" "pre" ]
        [ text (generate config) ]

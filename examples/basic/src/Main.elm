module Main exposing (main)

import Browser exposing (Document)
import Browser.Events exposing (onAnimationFrameDelta)
import Ecs exposing (Ecs)
import Html exposing (Html, text)
import Html.Attributes
import Model exposing (Model, ViewElement)
import Systems
import Time exposing (Posix, posixToMillis)



-- MODEL --


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model.init, Cmd.none )



-- UPDATE --


type Msg
    = OnAnimationFrameDelta Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnAnimationFrameDelta deltaTimeMillis ->
            let
                deltaTime =
                    min (deltaTimeMillis / 1000) maxDeltaTime
            in
            ( Systems.update { model | deltaTime = deltaTime }
            , Cmd.none
            )


maxDeltaTime : Float
maxDeltaTime =
    1.0 / 20.0



-- SUBSCRIPTIONS --


subscriptions : Model -> Sub Msg
subscriptions state =
    onAnimationFrameDelta OnAnimationFrameDelta



-- VIEW --


view : Model -> Document Msg
view model =
    { title = "Ecs Basic Example"
    , body =
        [ Html.div
            [ Html.Attributes.style "position" "relative"
            , Html.Attributes.style "display" "inline-block"
            , Html.Attributes.style "width" (String.fromInt model.worldWidth ++ "px")
            , Html.Attributes.style "height" (String.fromInt model.worldHeight ++ "px")
            , Html.Attributes.style "background-color" "#aaa"
            ]
            (List.map viewElement model.viewElements)
        ]
    }


viewElement : ViewElement -> Html msg
viewElement { position, color } =
    Html.div
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "display" "inline-block"
        , Html.Attributes.style "left" (String.fromInt (round position.x - 2) ++ "px")
        , Html.Attributes.style "top" (String.fromInt (round position.y - 2) ++ "px")
        , Html.Attributes.style "width" "4px"
        , Html.Attributes.style "height" "4px"
        , Html.Attributes.style "background-color" color
        ]
        []



-- MAIN --


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

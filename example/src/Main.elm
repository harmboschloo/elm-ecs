module Main exposing (main)

import Browser exposing (Document)
import Browser.Events exposing (onAnimationFrameDelta, onKeyDown, onKeyUp)
import Ecs exposing (Ecs)
import Ecs.EntityFactory exposing (createAiPredators, createHumanPredator)
import Ecs.Systems as Systems
import Ecs.Systems.KeyControls as KeyControls
    exposing
        ( ControlChange
        , KeyChange(..)
        , controlDecoder
        )
import Html exposing (Html, text)
import Json.Decode as Decode


type alias Model =
    { ecs : Ecs
    , stepCount : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { ecs =
            Ecs.init
                |> createHumanPredator
                |> createAiPredators
      , stepCount = 0
      }
    , Cmd.none
    )


type Msg
    = AnimationFrameStarted Float
    | KeyChanged ControlChange


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AnimationFrameStarted deltaTimeMillis ->
            let
                deltaTime =
                    min (deltaTimeMillis / 1000) (1.0 / 30.0)
            in
            ( { model
                | ecs = Systems.update deltaTime model.ecs
                , stepCount = model.stepCount + 1
              }
            , Cmd.none
            )

        KeyChanged controlChange ->
            ( { model | ecs = KeyControls.update controlChange model.ecs }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ onAnimationFrameDelta AnimationFrameStarted
        , onKeyUp (controlDecoder KeyUp |> Decode.map KeyChanged)
        , onKeyDown (controlDecoder KeyDown |> Decode.map KeyChanged)
        ]


view : Model -> Document Msg
view model =
    { title = "Ecs Example"
    , body =
        [ text <| "stepCount: " ++ String.fromInt model.stepCount
        , Systems.view model.ecs
        ]
    }


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

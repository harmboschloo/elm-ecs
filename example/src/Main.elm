module Main exposing (main)

import Browser exposing (Document)
import Browser.Events
    exposing
        ( onAnimationFrameDelta
        , onKeyDown
        , onKeyUp
        )
import Ecs exposing (Ecs)
import Ecs.EntityFactory exposing (createAiPredators, createHumanPredator)
import Ecs.Systems as Systems
import Ecs.Systems.KeyControls as KeyControls
    exposing
        ( KeyChange
        , Keys
        , keyDownDecoder
        , keyUpDecoder
        )
import Html exposing (Html, text)
import Html.Events exposing (keyCode)
import Json.Decode as Decode
import KeyCode exposing (KeyCode)


type alias Model =
    { ecs : Ecs
    , keys : Keys
    , stepCount : Int
    , running : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { ecs =
            Ecs.init
                |> createHumanPredator
                |> createAiPredators
      , keys = KeyControls.initKeys
      , stepCount = 0
      , running = True
      }
    , Cmd.none
    )


type Msg
    = AnimationFrameStarted Float
    | KeyChanged KeyChange
    | KeyReleased KeyCode


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AnimationFrameStarted deltaTimeMillis ->
            let
                deltaTime =
                    min (deltaTimeMillis / 1000) (1.0 / 30.0)
            in
            ( { model
                | ecs = Systems.update model.keys deltaTime model.ecs
                , stepCount = model.stepCount + 1
              }
            , Cmd.none
            )

        KeyChanged keyChange ->
            ( { model | keys = KeyControls.updateKeys keyChange model.keys }
            , Cmd.none
            )

        KeyReleased keyCode ->
            if keyCode == KeyCode.esc then
                ( { model | running = not model.running }
                , Cmd.none
                )

            else
                ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        keyUpSubscription =
            onKeyUp (Decode.map KeyReleased keyCode)
    in
    if model.running then
        Sub.batch
            [ onAnimationFrameDelta AnimationFrameStarted
            , onKeyUp (Decode.map KeyChanged keyUpDecoder)
            , onKeyDown (Decode.map KeyChanged keyDownDecoder)
            , keyUpSubscription
            ]

    else
        keyUpSubscription


view : Model -> Document Msg
view model =
    { title = "Ecs Example"
    , body =
        [ text <| "stepCount: " ++ String.fromInt model.stepCount
        , text <|
            if model.running then
                " running"

            else
                " paused"
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

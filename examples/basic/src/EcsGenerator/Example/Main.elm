module EcsGenerator.Example.Main exposing (main)

import Browser exposing (Document)
import Browser.Events exposing (onAnimationFrameDelta)
import EcsGenerator.Example.Ecs as Ecs exposing (Ecs)
import EcsGenerator.Example.Systems as Systems
import Html exposing (Html, text)
import Time exposing (Posix, posixToMillis)



-- MODEL --


type alias Model =
    { ecs : Ecs
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { ecs =
            Ecs.empty
                |> createEntity ( 50, 50 ) ( 50, 20 ) "#f00"
                |> createEntity ( 250, 50 ) ( -70, 90 ) "#0f0"
                |> createEntity ( 50, 250 ) ( 60, -40 ) "#00f"
                |> createEntity ( 250, 250 ) ( -80, -30 ) "#ff0"
                |> createEntity ( 150, 250 ) ( -120, -90 ) "#f0f"
                |> createEntity ( 250, 150 ) ( -80, 60 ) "#0ff"
                |> createEntity ( 150, 150 ) ( 65, -90 ) "#fff"
      }
    , Cmd.none
    )


createEntity : ( Float, Float ) -> ( Float, Float ) -> String -> Ecs -> Ecs
createEntity ( x, y ) ( velocityX, velocityY ) color ecs =
    let
        ( updatedEcs, entityId ) =
            Ecs.create ecs
    in
    updatedEcs
        |> Ecs.insert entityId Ecs.positionComponent { x = x, y = y }
        |> Ecs.insert entityId Ecs.velocityComponent { x = velocityX, y = velocityY }
        |> Ecs.insert entityId Ecs.colorComponent color



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
            ( { ecs =
                    ( model.ecs, deltaTime )
                        |> Systems.move
                        |> Systems.checkBounds
                        |> Tuple.first
              }
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
    , body = [ Systems.render model.ecs ]
    }



-- MAIN --


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

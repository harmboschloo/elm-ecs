module Main exposing (main)

import Browser exposing (Document)
import Browser.Events exposing (onAnimationFrameDelta)
import Ecs exposing (Ecs)
import Html exposing (Html, text)
import Systems
import Time exposing (Posix, posixToMillis)



-- MODEL --


type alias Model =
    { ecs : Ecs
    }


type BoundsResolution
    = Bounce
    | Teleport


init : () -> ( Model, Cmd Msg )
init _ =
    ( { ecs =
            Ecs.empty
                |> createMovingEntity ( 50, 50 ) ( 50, 20 ) Bounce "#f00"
                |> createMovingEntity ( 250, 50 ) ( -70, 90 ) Teleport "#0f0"
                |> createMovingEntity ( 50, 250 ) ( 60, -40 ) Bounce "#00f"
                |> createMovingEntity ( 250, 250 ) ( -80, -30 ) Teleport "#ff0"
                |> createMovingEntity ( 150, 250 ) ( -120, -90 ) Bounce "#f0f"
                |> createMovingEntity ( 250, 150 ) ( -80, 60 ) Teleport "#0ff"
                |> createStaticEntity ( 220, 140 ) "#fff"
                |> createStaticEntity ( 160, 180 ) "#fa0"
      }
    , Cmd.none
    )


createMovingEntity : ( Float, Float ) -> ( Float, Float ) -> BoundsResolution -> String -> Ecs -> Ecs
createMovingEntity ( x, y ) ( velocityX, velocityY ) boundsResolution color ecs =
    let
        ( updatedEcs, entityId ) =
            Ecs.create ecs
    in
    updatedEcs
        |> Ecs.insert entityId Ecs.positionComponent { x = x, y = y }
        |> Ecs.insert entityId Ecs.velocityComponent { x = velocityX, y = velocityY }
        |> Ecs.insert entityId Ecs.colorComponent color
        |> (case boundsResolution of
                Bounce ->
                    Ecs.insert entityId Ecs.bounceComponent { damping = 0.6 }

                Teleport ->
                    Ecs.insert entityId Ecs.teleportComponent ()
           )


createStaticEntity : ( Float, Float ) -> String -> Ecs -> Ecs
createStaticEntity ( x, y ) color ecs =
    let
        ( updatedEcs, entityId ) =
            Ecs.create ecs
    in
    updatedEcs
        |> Ecs.insert entityId Ecs.positionComponent { x = x, y = y }
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
                        |> Systems.checkBounce
                        |> Systems.checkTeleport
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

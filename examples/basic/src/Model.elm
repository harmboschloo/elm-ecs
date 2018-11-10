module Model exposing (Model, ViewElement, init)

import Components
import Ecs
import EcsSpecs exposing (Ecs)


type alias Model =
    { worldWidth : Int
    , worldHeight : Int
    , ecs : Ecs
    , deltaTime : Float
    , viewElements : List ViewElement
    }


type alias ViewElement =
    { position : Components.Position
    , color : Components.Color
    }


type BoundsResolution
    = Bounce
    | Teleport


init : Model
init =
    { worldWidth = 300
    , worldHeight = 300
    , ecs = initEcs
    , deltaTime = 0
    , viewElements = []
    }


initEcs : Ecs
initEcs =
    Ecs.empty
        |> createMovingEntity ( 50, 50 ) ( 50, 20 ) Bounce "#f00"
        |> createMovingEntity ( 250, 50 ) ( -70, 90 ) Teleport "#0f0"
        |> createMovingEntity ( 50, 250 ) ( 60, -40 ) Bounce "#00f"
        |> createMovingEntity ( 250, 250 ) ( -80, -30 ) Teleport "#ff0"
        |> createMovingEntity ( 150, 250 ) ( -120, -90 ) Bounce "#f0f"
        |> createMovingEntity ( 250, 150 ) ( -80, 60 ) Teleport "#0ff"
        |> createStaticEntity ( 220, 140 ) "#fff"
        |> createStaticEntity ( 160, 180 ) "#fa0"


createMovingEntity :
    ( Float, Float )
    -> ( Float, Float )
    -> BoundsResolution
    -> String
    -> Ecs
    -> Ecs
createMovingEntity ( x, y ) ( velocityX, velocityY ) boundsResolution color ecs =
    ecs
        |> Ecs.create EcsSpecs.entity
            (\entity ->
                entity
                    |> Ecs.set
                        EcsSpecs.components.position
                        { x = x, y = y }
                    |> Ecs.set
                        EcsSpecs.components.velocity
                        { x = velocityX, y = velocityY }
                    |> Ecs.set
                        EcsSpecs.components.color
                        color
                    |> (case boundsResolution of
                            Bounce ->
                                Ecs.set
                                    EcsSpecs.components.bounce
                                    { damping = 0.6 }

                            Teleport ->
                                Ecs.set
                                    EcsSpecs.components.teleport
                                    ()
                       )
            )
        |> Tuple.second


createStaticEntity : ( Float, Float ) -> String -> Ecs -> Ecs
createStaticEntity ( x, y ) color ecs =
    ecs
        |> Ecs.create EcsSpecs.entity
            (\entity ->
                entity
                    |> Ecs.set
                        EcsSpecs.components.position
                        { x = x, y = y }
                    |> Ecs.set
                        EcsSpecs.components.color
                        color
            )
        |> Tuple.second

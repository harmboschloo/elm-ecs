module Helpers.Random exposing (angleGenerator, positionGenerator, step)

import Components.Position exposing (Position)
import Ecs
import Random
import World exposing (World)


type alias Bounds =
    { width : Float
    , height : Float
    }


positionGenerator : Bounds -> Random.Generator Position
positionGenerator bounds =
    let
        marginX =
            bounds.width * 0.1

        marginY =
            bounds.height * 0.1
    in
    Random.map3 Position
        (Random.float marginX (bounds.width - marginX))
        (Random.float marginY (bounds.height - marginY))
        angleGenerator


angleGenerator : Random.Generator Float
angleGenerator =
    Random.float 0 (2 * pi)


step : Random.Generator a -> World -> ( a, World )
step generator world =
    let
        ( value, seed ) =
            Random.step
                generator
                (Ecs.getSingleton World.singletonSpecs.randomSeed world)
    in
    ( value, Ecs.setSingleton World.singletonSpecs.randomSeed seed world )

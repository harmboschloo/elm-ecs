module Ecs.Entities exposing (init)

import Assets exposing (Assets, Spritesheet)
import Ecs exposing (Ecs, EntityId)
import Ecs.Components
    exposing
        ( Controls
        , Motion
        , Position
        , Predator
        , Prey
        , Sprite
        , Velocity
        , defaultControls
        , defaultKeyControlsMap
        )
import WebGL.Texture exposing (Texture)
import World exposing (World)


init : Assets -> World -> Ecs
init assets world =
    Ecs.init
        |> createHumanPredator assets.spritesheet world
        |> createAiPredators assets.spritesheet world


createHumanPredator : Spritesheet -> World -> Ecs -> Ecs
createHumanPredator spritesheet world =
    Ecs.createEntity
        >> insertPredatorComponents
            spritesheet.playerShip1Green
            (world.width / 2)
            (world.height / 2)
        >> Ecs.andInsertComponent Ecs.keyControlsMap defaultKeyControlsMap
        >> Tuple.first


createAiPredators : Spritesheet -> World -> Ecs -> Ecs
createAiPredators spritesheet world ecs =
    List.range 1 9
        |> List.foldl
            (\value ->
                Ecs.createEntity
                    >> insertPredatorComponents
                        spritesheet.playerShip2Orange
                        (toFloat value / 10 * world.width)
                        (world.height / 4)
                    >> Ecs.andInsertComponent Ecs.ai ()
                    >> Tuple.first
            )
            ecs


insertPredatorComponents :
    Sprite
    -> Float
    -> Float
    -> ( Ecs, EntityId )
    -> ( Ecs, EntityId )
insertPredatorComponents sprite x y =
    Ecs.andInsertComponent Ecs.sprite sprite
        >> Ecs.andInsertComponent Ecs.position (Position x y 0)
        >> Ecs.andInsertComponent Ecs.controls defaultControls
        >> Ecs.andInsertComponent Ecs.motion predatorMotion
        >> Ecs.andInsertComponent Ecs.velocity (Velocity 0 0 (pi / 2))
        >> Ecs.andInsertComponent Ecs.predator ()


predatorMotion : Motion
predatorMotion =
    { maxAcceleration = 50
    , maxDeceleration = 25
    , maxAngularAcceleration = 20
    , maxAngularVelocity = 50
    }

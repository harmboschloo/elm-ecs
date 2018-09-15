module Ecs.Entities exposing (createAiPredators, createHumanPredator)

import Assets exposing (Spritesheet)
import Ecs exposing (Ecs, EntityId)
import Ecs.Components
    exposing
        ( Controls
        , Display
        , Motion
        , Position
        , Predator
        , Prey
        , Sprite
        , Velocity
        , defaultControls
        , defaultKeyControlsMap
        )


createHumanPredator : Spritesheet -> Ecs -> Ecs
createHumanPredator spritesheet =
    Ecs.createEntity
        >> insertPredatorComponents
            spritesheet.playerShip1Green
            250
            250
            "#00ff00"
        >> Ecs.andInsertComponent Ecs.keyControlsMap defaultKeyControlsMap
        >> Tuple.first


createAiPredators : Spritesheet -> Ecs -> Ecs
createAiPredators spritesheet ecs =
    List.range 1 9
        |> List.foldl
            (\value ->
                Ecs.createEntity
                    >> insertPredatorComponents
                        spritesheet.playerShip2Orange
                        (toFloat value * 50.0)
                        125
                        "#ff0000"
                    >> Ecs.andInsertComponent Ecs.ai ()
                    >> Tuple.first
            )
            ecs


insertPredatorComponents : Sprite -> Float -> Float -> String -> ( Ecs, EntityId ) -> ( Ecs, EntityId )
insertPredatorComponents sprite x y color =
    Ecs.andInsertComponent Ecs.sprite sprite
        >> Ecs.andInsertComponent Ecs.position (Position x y 0)
        >> Ecs.andInsertComponent Ecs.controls defaultControls
        >> Ecs.andInsertComponent Ecs.motion predatorMotion
        >> Ecs.andInsertComponent Ecs.velocity (Velocity 0 0 (pi / 2))
        >> Ecs.andInsertComponent Ecs.display (Display color)
        >> Ecs.andInsertComponent Ecs.predator ()


predatorMotion : Motion
predatorMotion =
    { maxAcceleration = 50
    , maxDeceleration = 25
    , maxAngularAcceleration = 20
    , maxAngularVelocity = 50
    }

module Ecs.EntityFactory exposing (createAiPredators, createHumanPredator)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components
    exposing
        ( Controls
        , Display
        , Motion
        , Position
        , Predator
        , Prey
        , Velocity
        , defaultControls
        , defaultKeyControlsMap
        )


predatorMotion : Motion
predatorMotion =
    { maxAcceleration = 1
    , maxDeceleration = 0.5
    , maxAngularAcceleration = 5
    , maxAngularVelocity = 20
    }


createAiPredators : Ecs -> Ecs
createAiPredators ecs =
    List.range 1 9
        |> List.foldl
            (\value ->
                Ecs.createEntity
                    >> insertPredatorComponents (toFloat value / 10.0) 0.5 "#ff0000"
                    >> Ecs.andInsertComponent Ecs.ai ()
                    >> Tuple.first
            )
            ecs


createHumanPredator : Ecs -> Ecs
createHumanPredator =
    Ecs.createEntity
        >> insertPredatorComponents 0.5 0.25 "#00ff00"
        >> Ecs.andInsertComponent Ecs.keyControlsMap defaultKeyControlsMap
        >> Tuple.first


insertPredatorComponents : Float -> Float -> String -> ( Ecs, EntityId ) -> ( Ecs, EntityId )
insertPredatorComponents x y color =
    Ecs.andInsertComponent Ecs.position (Position x y 0)
        >> Ecs.andInsertComponent Ecs.controls defaultControls
        >> Ecs.andInsertComponent Ecs.motion predatorMotion
        >> Ecs.andInsertComponent Ecs.velocity (Velocity 0 0 0)
        >> Ecs.andInsertComponent Ecs.display (Display color)
        >> Ecs.andInsertComponent Ecs.predator ()

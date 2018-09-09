module Ecs.EntityFactory exposing (createAiPredators, createHumanPredator)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components
    exposing
        ( Acceleration
        , Controls
        , Display
        , Position
        , Predator
        , Prey
        , Velocity
        )


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
        >> Ecs.andInsertComponent Ecs.human ()
        >> Tuple.first


insertPredatorComponents : Float -> Float -> String -> ( Ecs, EntityId ) -> ( Ecs, EntityId )
insertPredatorComponents x y color =
    Ecs.andInsertComponent Ecs.position (Position x y 0)
        >> Ecs.andInsertComponent Ecs.controls (Controls False False False False)
        >> Ecs.andInsertComponent Ecs.acceleration (Acceleration 0 0 0)
        >> Ecs.andInsertComponent Ecs.velocity (Velocity 0.1 0 1)
        >> Ecs.andInsertComponent Ecs.display (Display color)
        >> Ecs.andInsertComponent Ecs.predator ()

module Systems.Animation exposing (update)

import Core.Animation.Sequence as Animation exposing (Animation)
import Ecs
import Ecs.Select
import Timing.Timer as Timer
import World exposing (World)


scaleAnimationSelector : World.Selector World.ScaleAnimation
scaleAnimationSelector =
    Ecs.Select.component World.componentSpecs.scaleAnimation
        |> Ecs.Select.andHas World.componentSpecs.scale


update : World -> World
update =
    Ecs.processAll scaleAnimationSelector updateEntity


updateEntity : ( Ecs.EntityId, World.ScaleAnimation ) -> World -> World
updateEntity ( entityId, scaleAnimation ) world =
    let
        timer =
            Ecs.getSingleton World.singletonSpecs.timer world

        elapsedTime =
            Timer.elapsedTime timer
    in
    world
        |> Ecs.insertComponent World.componentSpecs.scale
            entityId
            (Animation.animate elapsedTime scaleAnimation)
        |> (if Animation.hasEnded elapsedTime scaleAnimation then
                Ecs.removeComponent World.componentSpecs.scaleAnimation entityId

            else
                identity
           )

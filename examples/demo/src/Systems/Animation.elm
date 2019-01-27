module Systems.Animation exposing (update)

import Animation.Sequence as Animation exposing (Animation)
import Components exposing (ScaleAnimation)
import Ecs
import Ecs.Select
import Global exposing (Global)
import World exposing (EntityId, Selector, World, specs)


scaleAnimationSelector : Selector ScaleAnimation
scaleAnimationSelector =
    Ecs.Select.component specs.scaleAnimation
        |> Ecs.Select.andHas specs.scale


update : ( World, Global ) -> ( World, Global )
update =
    Ecs.processAllWithState scaleAnimationSelector updateEntity


updateEntity :
    ( EntityId, ScaleAnimation )
    -> ( World, Global )
    -> ( World, Global )
updateEntity ( entityId, scaleAnimation ) ( world, global ) =
    let
        time =
            Global.getTime global
    in
    ( world
        |> Ecs.insert specs.scale
            entityId
            (Animation.animate time scaleAnimation)
        |> (if Animation.hasEnded time scaleAnimation then
                Ecs.remove specs.scaleAnimation entityId

            else
                identity
           )
    , global
    )

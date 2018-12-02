module Systems.Animation exposing (update)

import Components exposing (ScaleAnimation)
import Data.Animation as Animation exposing (Animation)
import Ecs exposing (Ecs)
import Global exposing (Global)


scaleAnimationSelector : Ecs.Selector ScaleAnimation
scaleAnimationSelector =
    Ecs.component .scaleAnimation
        |> Ecs.andHas .scale


update : ( Global, Ecs ) -> ( Global, Ecs )
update =
    Ecs.process scaleAnimationSelector updateEntity


updateEntity :
    ( Ecs.EntityId, ScaleAnimation )
    -> ( Global, Ecs )
    -> ( Global, Ecs )
updateEntity ( entityId, scaleAnimation ) ( global, ecs ) =
    let
        time =
            Global.getTime global
    in
    ( global
    , ecs
        |> Ecs.insert .scale entityId (Animation.animate time scaleAnimation)
        |> (if Animation.hasEnded time scaleAnimation then
                Ecs.remove .scaleAnimation entityId

            else
                identity
           )
    )

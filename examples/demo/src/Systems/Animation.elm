module Systems.Animation exposing (update)

import Components exposing (ScaleAnimation)
import Data.Animation as Animation exposing (Animation)
import Entities exposing (Entities, EntityId, Selector)
import Global exposing (Global)


scaleAnimationSelector : Selector ScaleAnimation
scaleAnimationSelector =
    Entities.selectComponent .scaleAnimation
        |> Entities.andHas .scale


update : ( Global, Entities ) -> ( Global, Entities )
update =
    Entities.process scaleAnimationSelector updateEntity


updateEntity :
    ( EntityId, ScaleAnimation )
    -> ( Global, Entities )
    -> ( Global, Entities )
updateEntity ( entityId, scaleAnimation ) ( global, entities ) =
    let
        time =
            Global.getTime global
    in
    ( global
    , Entities.updateEcs
        (\ecs ->
            ecs
                |> Entities.insert .scale
                    entityId
                    (Animation.animate time scaleAnimation)
                |> (if Animation.hasEnded time scaleAnimation then
                        Entities.remove .scaleAnimation entityId

                    else
                        identity
                   )
        )
        entities
    )

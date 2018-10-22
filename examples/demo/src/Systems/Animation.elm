module Systems.Animation exposing (update)

import Components exposing (ScaleAnimation)
import Context exposing (Context)
import Data.Animation as Animation exposing (Animation)
import Ecs exposing (Ecs)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterate Ecs.scaleAnimationComponent updateScale


updateScale :
    Ecs.EntityId
    -> ScaleAnimation
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateScale entityId scaleAnimation ( ecs, context ) =
    let
        newEcs =
            Ecs.insert
                entityId
                Ecs.scaleComponent
                (Animation.animate context.time scaleAnimation)
                ecs
    in
    if Animation.hasEnded context.time scaleAnimation then
        ( Ecs.remove entityId Ecs.scaleAnimationComponent newEcs
        , context
        )

    else
        ( newEcs, context )

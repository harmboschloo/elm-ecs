module Systems.Animation exposing (update)

import Context exposing (Context)
import Data.Animation as Animation exposing (Animation)
import Ecs exposing (Ecs)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterateEntities Ecs.scaleAnimationNode updateScale


updateScale :
    Ecs.EntityId
    -> Ecs.ScaleAnimationNode
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateScale entityId { scaleAnimation } ( ecs, context ) =
    let
        newEcs =
            Ecs.insertComponent
                entityId
                Ecs.scaleComponent
                (Animation.animate context.time scaleAnimation)
                ecs
    in
    if Animation.hasEnded context.time scaleAnimation then
        ( Ecs.removeComponent entityId Ecs.scaleAnimationComponent newEcs
        , context
        )

    else
        ( newEcs, context )

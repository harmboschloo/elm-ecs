module Systems.Animation exposing (update)

import Context exposing (Context)
import Data.Animation exposing (Animation, animate)
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
    ( Ecs.insertComponent
        entityId
        Ecs.scaleComponent
        (animate context.time scaleAnimation)
        ecs
    , context
    )

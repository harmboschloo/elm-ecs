module Systems.Animation exposing (update)

import Components exposing (Scale, ScaleAnimation)
import Context exposing (Context)
import Data.Animation exposing (Animation, animate)
import Ecs exposing (Ecs, EntityId)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterateEntities2 Ecs.scaleAnimation Ecs.scale updateScale


updateScale :
    EntityId
    -> Animation
    -> Scale
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateScale entityId animation scale ( ecs, context ) =
    ( Ecs.insertComponent
        entityId
        Ecs.scale
        (animate context.time animation)
        ecs
    , context
    )

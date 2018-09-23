module Ecs.Systems.Animation exposing (update)

import Animation exposing (Animation)
import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Scale, ScaleAnimation)
import Ecs.Context exposing (Context)


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
        (Animation.animate context.time animation)
        ecs
    , context
    )

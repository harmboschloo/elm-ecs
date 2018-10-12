module Systems.Destroy exposing (update)

import Context exposing (Context)
import Ecs exposing (Ecs)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterateEntities Ecs.destroyNode updateEntity


updateEntity :
    Ecs.EntityId
    -> Ecs.DestroyNode
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateEntity entityId node ( ecs, context ) =
    if context.time >= node.destroy.time then
        ( Ecs.destroyEntity entityId ecs, context )

    else
        ( ecs, context )

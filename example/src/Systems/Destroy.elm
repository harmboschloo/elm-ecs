module Systems.Destroy exposing (update)

import Components exposing (Destroy)
import Context exposing (Context)
import Ecs exposing (Ecs, EntityId)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterateEntities Ecs.destroy updateEntity


updateEntity :
    EntityId
    -> Destroy
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateEntity entityId destroy ( ecs, context ) =
    if context.time >= destroy.time then
        ( Ecs.resetEntity entityId ecs, context )

    else
        ( ecs, context )

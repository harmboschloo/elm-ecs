module Ecs.Systems.Destroy exposing (update)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Destroy)
import Ecs.Context exposing (Context)


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

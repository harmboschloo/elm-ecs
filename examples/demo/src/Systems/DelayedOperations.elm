module Systems.DelayedOperations exposing (update)

import Components.DelayedOperations as DelayedOperations
    exposing
        ( DelayedOperations
        , Operation
        )
import Ecs exposing (Ecs)
import Global exposing (Global)


delayedOperationsSelector : Ecs.Selector DelayedOperations
delayedOperationsSelector =
    Ecs.component .delayedOperations


update : ( Global, Ecs ) -> ( Global, Ecs )
update =
    Ecs.process delayedOperationsSelector updateEntity


updateEntity :
    ( Ecs.EntityId, DelayedOperations )
    -> ( Global, Ecs )
    -> ( Global, Ecs )
updateEntity ( entityId, operations1 ) ( global1, ecs1 ) =
    let
        ( operations2, global2, ecs2 ) =
            List.foldr
                (updateOperation (Global.getTime global1) entityId)
                ( [], global1, ecs1 )
                operations1
    in
    ( global2
    , case operations2 of
        [] ->
            Ecs.remove .delayedOperations entityId ecs2

        _ ->
            Ecs.insert .delayedOperations entityId operations2 ecs2
    )


updateOperation :
    Float
    -> Ecs.EntityId
    -> ( Float, Operation )
    -> ( DelayedOperations, Global, Ecs )
    -> ( DelayedOperations, Global, Ecs )
updateOperation time entityId ( operationTime, operation ) ( operations, global1, ecs1 ) =
    if operationTime > time then
        ( ( operationTime, operation ) :: operations, global1, ecs1 )

    else
        let
            ( global2, ecs2 ) =
                handleOperation entityId operation global1 ecs1
        in
        ( operations, global2, ecs2 )


handleOperation :
    Ecs.EntityId
    -> Operation
    -> Global
    -> Ecs
    -> ( Global, Ecs )
handleOperation entityId operation global ecs =
    case operation of
        DelayedOperations.RemoveEntity ->
            Global.removeEntity entityId ( global, ecs )

        DelayedOperations.InsertCollisionShape collisionShape ->
            ( global, Ecs.insert .collisionShape entityId collisionShape ecs )

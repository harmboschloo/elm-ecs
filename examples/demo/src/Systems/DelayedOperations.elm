module Systems.DelayedOperations exposing (update)

import Components.DelayedOperations as DelayedOperations
    exposing
        ( DelayedOperations
        , Operation
        )
import Ecs
import Ecs.Select
import Global exposing (Global)
import World exposing (EntityId, Selector, World, specs)


delayedOperationsSelector : Selector DelayedOperations
delayedOperationsSelector =
    Ecs.Select.component specs.delayedOperations


update : ( World, Global ) -> ( World, Global )
update =
    Ecs.processAllWithState delayedOperationsSelector updateEntity


updateEntity :
    ( EntityId, DelayedOperations )
    -> ( World, Global )
    -> ( World, Global )
updateEntity ( entityId, operations1 ) ( world1, global ) =
    let
        ( operations2, world2 ) =
            List.foldr
                (updateOperation (Global.getTime global) entityId)
                ( [], world1 )
                operations1
    in
    ( case operations2 of
        [] ->
            Ecs.remove specs.delayedOperations entityId world2

        _ ->
            Ecs.insert specs.delayedOperations entityId operations2 world2
    , global
    )


updateOperation :
    Float
    -> EntityId
    -> ( Float, Operation )
    -> ( DelayedOperations, World )
    -> ( DelayedOperations, World )
updateOperation time entityId ( operationTime, operation ) ( operations, world ) =
    if operationTime > time then
        ( ( operationTime, operation ) :: operations, world )

    else
        ( operations, handleOperation entityId operation world )


handleOperation : EntityId -> Operation -> World -> World
handleOperation entityId operation world =
    case operation of
        DelayedOperations.RemoveEntity ->
            Ecs.destroy specs.all entityId world

        DelayedOperations.InsertCollisionShape collisionShape ->
            Ecs.insert specs.collisionShape entityId collisionShape world

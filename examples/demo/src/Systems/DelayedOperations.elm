module Systems.DelayedOperations exposing (update)

import Ecs
import Ecs.Select
import Timing.Timer as Timer
import World exposing (World)
import World.DelayedOperations as DelayedOperations
    exposing
        ( DelayedOperations
        , Operation
        )


delayedOperationsSelector : World.Selector DelayedOperations
delayedOperationsSelector =
    Ecs.Select.component World.componentSpecs.delayedOperations


update : World -> World
update =
    Ecs.processAll delayedOperationsSelector updateEntity


updateEntity :
    ( Ecs.EntityId, DelayedOperations )
    -> World
    -> World
updateEntity ( entityId, operations1 ) world1 =
    let
        timer =
            Ecs.getSingleton World.singletonSpecs.timer world1

        elapsedTime =
            Timer.elapsedTime timer

        ( operations2, world2 ) =
            List.foldr
                (updateOperation elapsedTime entityId)
                ( [], world1 )
                operations1
    in
    case operations2 of
        [] ->
            Ecs.removeComponent
                World.componentSpecs.delayedOperations
                entityId
                world2

        _ ->
            Ecs.insertComponent
                World.componentSpecs.delayedOperations
                entityId
                operations2
                world2


updateOperation :
    Float
    -> Ecs.EntityId
    -> ( Float, Operation )
    -> ( DelayedOperations, World )
    -> ( DelayedOperations, World )
updateOperation time entityId ( operationTime, operation ) ( operations, world ) =
    if operationTime > time then
        ( ( operationTime, operation ) :: operations, world )

    else
        ( operations, handleOperation entityId operation world )


handleOperation : Ecs.EntityId -> Operation -> World -> World
handleOperation entityId operation world =
    case operation of
        DelayedOperations.RemoveEntity ->
            Ecs.destroyEntity World.componentSpecs.all entityId world

        DelayedOperations.InsertCollidable collidable ->
            Ecs.insertComponent
                World.componentSpecs.collidable
                entityId
                collidable
                world

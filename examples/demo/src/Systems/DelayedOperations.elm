module Systems.DelayedOperations exposing (update)

import Components.DelayedOperations as DelayedOperations
    exposing
        ( DelayedOperations
        , Operation
        )
import Entities exposing (Entities, EntityId, Selector)
import Global exposing (Global)


delayedOperationsSelector : Selector DelayedOperations
delayedOperationsSelector =
    Entities.selectComponent .delayedOperations


update : ( Global, Entities ) -> ( Global, Entities )
update =
    Entities.process delayedOperationsSelector updateEntity


updateEntity :
    ( EntityId, DelayedOperations )
    -> ( Global, Entities )
    -> ( Global, Entities )
updateEntity ( entityId, operations1 ) ( global, entities1 ) =
    let
        ( operations2, entities2 ) =
            List.foldr
                (updateOperation (Global.getTime global) entityId)
                ( [], entities1 )
                operations1
    in
    ( global
    , Entities.updateEcs
        (\ecs ->
            case operations2 of
                [] ->
                    Entities.remove .delayedOperations
                        entityId
                        ecs

                _ ->
                    Entities.insert .delayedOperations
                        entityId
                        operations2
                        ecs
        )
        entities2
    )


updateOperation :
    Float
    -> EntityId
    -> ( Float, Operation )
    -> ( DelayedOperations, Entities )
    -> ( DelayedOperations, Entities )
updateOperation time entityId ( operationTime, operation ) ( operations, entities ) =
    if operationTime > time then
        ( ( operationTime, operation ) :: operations, entities )

    else
        ( operations, handleOperation entityId operation entities )


handleOperation : EntityId -> Operation -> Entities -> Entities
handleOperation entityId operation entities =
    case operation of
        DelayedOperations.RemoveEntity ->
            Entities.removeEntity entityId entities

        DelayedOperations.InsertCollisionShape collisionShape ->
            Entities.updateEcs
                (\ecs ->
                    Entities.insert .collisionShape
                        entityId
                        collisionShape
                        ecs
                )
                entities

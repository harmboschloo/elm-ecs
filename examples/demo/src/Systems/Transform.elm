module Systems.Transform exposing (system)

import Components.Transforms as Transforms exposing (Transform, Transforms)
import Ecs exposing (Ecs)
import Entity exposing (Entity, components)
import State exposing (State)


node : Ecs.Node Entity Transforms
node =
    Ecs.node1 identity components.transforms


system : Ecs.System Entity State
system =
    Ecs.processor node updateEntity


updateEntity :
    Transforms
    -> Ecs.EntityId
    -> Ecs Entity
    -> State
    -> ( Ecs Entity, State )
updateEntity transforms1 entityId ecs1 state =
    let
        ( transforms2, ecs2 ) =
            List.foldr
                (updateTransform state.time entityId)
                ( [], ecs1 )
                transforms1
    in
    case transforms2 of
        [] ->
            ( Ecs.remove components.transforms entityId ecs2
            , state
            )

        _ ->
            ( Ecs.set components.transforms transforms2 entityId ecs2
            , state
            )


updateTransform :
    Float
    -> Ecs.EntityId
    -> Transform
    -> ( Transforms, Ecs Entity )
    -> ( Transforms, Ecs Entity )
updateTransform time entityId transform ( transforms, ecs ) =
    if transform.time > time then
        ( transform :: transforms, ecs )

    else
        ( transforms, handleTransform entityId transform ecs )


handleTransform : Ecs.EntityId -> Transform -> Ecs Entity -> Ecs Entity
handleTransform entityId transform ecs =
    case transform.type_ of
        Transforms.DestroyEntity ->
            Ecs.destroy entityId ecs

        Transforms.InsertCollectable collectable ->
            Ecs.set components.collectable collectable entityId ecs

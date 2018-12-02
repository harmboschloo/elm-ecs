module Systems.Transform exposing (update)

import Components.Transforms as Transforms exposing (Transform, Transforms)
import Ecs exposing (Ecs)
import Global exposing (Global)


transformsSelector : Ecs.Selector Transforms
transformsSelector =
    Ecs.component .transforms


update : ( Global, Ecs ) -> ( Global, Ecs )
update =
    Ecs.process transformsSelector updateEntity


updateEntity : ( Ecs.EntityId, Transforms ) -> ( Global, Ecs ) -> ( Global, Ecs )
updateEntity ( entityId, transforms1 ) ( global1, ecs1 ) =
    let
        ( transforms2, global2, ecs2 ) =
            List.foldr
                (updateTransform (Global.getTime global1) entityId)
                ( [], global1, ecs1 )
                transforms1
    in
    ( global2
    , case transforms2 of
        [] ->
            Ecs.remove .transforms entityId ecs2

        _ ->
            Ecs.insert .transforms entityId transforms2 ecs2
    )


updateTransform :
    Float
    -> Ecs.EntityId
    -> Transform
    -> ( Transforms, Global, Ecs )
    -> ( Transforms, Global, Ecs )
updateTransform time entityId transform ( transforms, global1, ecs1 ) =
    if transform.time > time then
        ( transform :: transforms, global1, ecs1 )

    else
        let
            ( global2, ecs2 ) =
                handleTransform entityId transform global1 ecs1
        in
        ( transforms, global2, ecs2 )


handleTransform : Ecs.EntityId -> Transform -> Global -> Ecs -> ( Global, Ecs )
handleTransform entityId transform global ecs =
    case transform.type_ of
        Transforms.DestroyEntity ->
            Global.removeEntity entityId ( global, ecs )

        Transforms.InsertCollectable collectable ->
            ( global, Ecs.insert .collectable entityId collectable ecs )

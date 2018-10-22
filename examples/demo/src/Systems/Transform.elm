module Systems.Transform exposing (update)

import Components.Transforms as Transforms exposing (Transform, Transforms)
import Context exposing (Context)
import Ecs exposing (Ecs)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterate Ecs.transformsComponent updateEntity


updateEntity :
    Ecs.EntityId
    -> Transforms
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateEntity entityId transforms data =
    let
        ( newTransforms, ( ecs, context ) ) =
            List.foldr
                (updateTransform entityId)
                ( [], data )
                transforms
    in
    case newTransforms of
        [] ->
            ( Ecs.remove
                entityId
                Ecs.transformsComponent
                ecs
            , context
            )

        _ ->
            ( Ecs.insert
                entityId
                Ecs.transformsComponent
                transforms
                ecs
            , context
            )


updateTransform :
    Ecs.EntityId
    -> Transform
    -> ( Transforms, ( Ecs, Context ) )
    -> ( Transforms, ( Ecs, Context ) )
updateTransform entityId transform ( transforms, ( ecs, context ) ) =
    if transform.time > context.time then
        ( transform :: transforms, ( ecs, context ) )

    else
        ( transforms, ( handleTransform entityId transform ecs, context ) )


handleTransform : Ecs.EntityId -> Transform -> Ecs -> Ecs
handleTransform entityId transform ecs =
    case transform.type_ of
        Transforms.DestroyEntity ->
            Ecs.destroy entityId ecs

        Transforms.InsertCollectable collectable ->
            Ecs.insert entityId
                Ecs.collectableComponent
                collectable
                ecs

module Systems.Transform exposing (update)

import Components.Transforms as Transforms exposing (Transform, Transforms)
import Context exposing (Context)
import Ecs exposing (Ecs)


update : ( Ecs, Context ) -> ( Ecs, Context )
update =
    Ecs.iterateEntities Ecs.transformNode updateEntity


updateEntity :
    Ecs.EntityId
    -> Ecs.TransformNode
    -> ( Ecs, Context )
    -> ( Ecs, Context )
updateEntity entityId node data =
    let
        ( transforms, ( ecs, context ) ) =
            List.foldr
                (updateTransform entityId)
                ( [], data )
                node.transforms
    in
    case transforms of
        [] ->
            ( Ecs.removeComponent
                entityId
                Ecs.transformsComponent
                ecs
            , context
            )

        _ ->
            ( Ecs.insertComponent
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
            Ecs.destroyEntity entityId ecs

        Transforms.InsertCollectable collectable ->
            Ecs.insertComponent entityId
                Ecs.collectableComponent
                collectable
                ecs

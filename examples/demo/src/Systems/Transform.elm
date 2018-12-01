module Systems.Transform exposing (update)

import Components.Transforms as Transforms exposing (Transform, Transforms)
import Ecs.Select
import Game exposing (EntityId, Game)


transformsSelector : Game.Selector Transforms
transformsSelector =
    Ecs.Select.component Game.components.transforms


update : Game -> Game
update =
    Game.process transformsSelector updateEntity


updateEntity : ( EntityId, Transforms ) -> Game -> Game
updateEntity ( entityId, transforms1 ) game1 =
    let
        ( transforms2, game2 ) =
            List.foldr
                (updateTransform (Game.getTime game1) entityId)
                ( [], game1 )
                transforms1
    in
    case transforms2 of
        [] ->
            Game.remove Game.components.transforms entityId game2

        _ ->
            Game.insert Game.components.transforms entityId transforms2 game2


updateTransform :
    Float
    -> EntityId
    -> Transform
    -> ( Transforms, Game )
    -> ( Transforms, Game )
updateTransform time entityId transform ( transforms, game ) =
    if transform.time > time then
        ( transform :: transforms, game )

    else
        ( transforms, handleTransform entityId transform game )


handleTransform : EntityId -> Transform -> Game -> Game
handleTransform entityId transform game =
    case transform.type_ of
        Transforms.DestroyEntity ->
            Game.removeEntity entityId game

        Transforms.InsertCollectable collectable ->
            Game.insert Game.components.collectable entityId collectable game

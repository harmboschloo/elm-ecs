module Ecs.Process exposing
    ( Process
    , getId, get, set, update, destroy
    , createEntity, destroyEntity, getEntity, updateEntity
    )

{-|

@docs Process
@docs getId, get, set, remove, update, destroy
@docs createEntity, destroyEntity, getEntity, updateEntity

-}

import Ecs
import Ecs.Internal.Entity exposing (EntityId)
import Ecs.Internal.Process as Process exposing (Status(..))
import Ecs.Update exposing (Update)


{-| -}
type alias Process a =
    Process.Process a



-- CURRENT ENTITY --


{-| -}
getId : Process a -> EntityId
getId (Process.Process model) =
    model.current.id


{-| -}
get : (a -> Maybe b) -> Process a -> Maybe b
get getB (Process.Process model) =
    case model.current.status of
        Destroyed ->
            Nothing

        _ ->
            getB model.current.a


{-| -}
set : Update a b -> b -> Process a -> Process a
set setB b process =
    setComponent setB (Just b) process


{-| -}
remove : Update a b -> Process a -> Process a
remove setB process =
    setComponent setB Nothing process


{-| -}
update :
    (a -> Maybe b)
    -> Update a b
    -> (Maybe b -> Maybe b)
    -> Process a
    -> Process a
update getB setB fn (Process.Process model) =
    case model.current.status of
        Destroyed ->
            Process.Process model

        _ ->
            Process.Process
                { ecs = model.ecs
                , current =
                    { id = model.current.id
                    , a = setB (fn (getB model.current.a)) model.current.a
                    , status = Modified
                    }
                , update = model.update
                }


{-| -}
destroy : Process a -> Process a
destroy (Process.Process model) =
    case model.current.status of
        Destroyed ->
            Process.Process model

        _ ->
            Process.Process
                { ecs = model.ecs
                , current =
                    { id = model.current.id
                    , a = model.current.a
                    , status = Destroyed
                    }
                , update = model.update
                }


setComponent : Update a b -> Maybe b -> Process a -> Process a
setComponent setB b (Process.Process model) =
    case model.current.status of
        Destroyed ->
            Process.Process model

        _ ->
            Process.Process
                { ecs = model.ecs
                , current =
                    { id = model.current.id
                    , a = setB b model.current.a
                    , status = Modified
                    }
                , update = model.update
                }



-- ECS ENTITIES --


{-| -}
createEntity : a -> Process a -> ( EntityId, Process a )
createEntity a (Process.Process model) =
    let
        ( entityId, ecs ) =
            Ecs.create a model.ecs
    in
    ( entityId
    , Process.Process
        { ecs = ecs
        , current = model.current
        , update = model.update
        }
    )


{-| -}
destroyEntity : EntityId -> Process a -> Process a
destroyEntity entityId (Process.Process model) =
    Process.Process
        { ecs = Ecs.destroy entityId model.ecs
        , current = model.current
        , update = model.update
        }


{-| -}
getEntity : EntityId -> Process a -> Maybe a
getEntity entityId (Process.Process model) =
    Ecs.get entityId model.ecs


{-| -}
updateEntity : EntityId -> (a -> a) -> Process a -> Process a
updateEntity entityId fn (Process.Process model) =
    Process.Process
        { ecs = model.ecs
        , current = model.current
        , update = ( entityId, fn ) :: model.update
        }

module Ecs exposing
    ( empty, isEmpty, entityCount, componentCount, ids
    , member, clear
    , has, get, insert, update, remove, size
    , select, selectList
    , EntityId, create, destroy
    )

{-|


# Model

@docs empty, isEmpty, entityCount, componentCount, ids


# Entity

@docs member, clear


# Component

@docs has, get, insert, update, remove, size


# Apply Selectors

@docs select, selectList

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , Selector(..)
        , Spec(..)
        )
import Set exposing (Set)



-- MODEL --


{-| Create an empty ecs.
-}
empty : Spec ecs -> ecs
empty (Spec spec) =
    spec.empty


{-| Determine if the ecs is empty
-}
isEmpty : Spec ecs -> ecs -> Bool
isEmpty (Spec spec) ecs =
    spec.isEmpty ecs


{-| Determine the total number of entities in the ecs.
-}
entityCount : Spec ecs -> ecs -> Int
entityCount (Spec spec) ecs =
    Set.size (spec.ids ecs)


{-| Determine the total number of components in the ecs.
-}
componentCount : Spec ecs -> ecs -> Int
componentCount (Spec spec) ecs =
    spec.componentCount ecs


{-| Get all entity ids in the ecs.
-}
ids : Spec ecs -> ecs -> List EntityId
ids (Spec spec) ecs =
    spec.ids ecs
        |> Set.toList
        |> List.map Internal.EntityId



-- ENTITY --


type alias EntityId =
    Internal.EntityId


create : Spec ecs -> ecs -> ( ecs, EntityId )
create (Spec spec) ecs =
    spec.create ecs


destroy : Spec ecs -> EntityId -> ecs -> ecs
destroy (Spec spec) entityId ecs =
    spec.destroy entityId ecs


{-| Determine if an entity is in the ecs.
-}
member : Spec ecs -> EntityId -> ecs -> Bool
member (Spec spec) entityId ecs =
    spec.member entityId ecs


{-| Remove all components of an entity.
-}
clear : Spec ecs -> EntityId -> ecs -> ecs
clear (Spec spec) entityId ecs =
    spec.clear entityId ecs



-- COMPONENTS --


{-| Determines if an entity has a specific component.
-}
has : ComponentSpec ecs a -> EntityId -> ecs -> Bool
has (ComponentSpec spec) (Internal.EntityId entityId) ecs =
    Dict.member entityId (spec.get ecs)


{-| Get a specific component of an entity.
-}
get : ComponentSpec ecs a -> EntityId -> ecs -> Maybe a
get (ComponentSpec spec) (Internal.EntityId entityId) ecs =
    Dict.get entityId (spec.get ecs)


{-| Insert a specific component in an entity.
-}
insert : ComponentSpec ecs a -> EntityId -> a -> ecs -> ecs
insert (ComponentSpec spec) (Internal.EntityId entityId) a ecs =
    -- TODO check member
    spec.update (\dict -> Dict.insert entityId a dict) ecs


{-| Update a specific component in an entity.
-}
update :
    ComponentSpec ecs a
    -> EntityId
    -> (Maybe a -> Maybe a)
    -> ecs
    -> ecs
update (ComponentSpec spec) (Internal.EntityId entityId) fn ecs =
    -- TODO check member
    spec.update (\dict -> Dict.update entityId fn dict) ecs


{-| Remove a specific component from an entity.
-}
remove : ComponentSpec ecs a -> EntityId -> ecs -> ecs
remove (ComponentSpec spec) (Internal.EntityId entityId) ecs =
    spec.update (\dict -> Dict.remove entityId dict) ecs


{-| Determine the total number of components of a specific type.
-}
size : ComponentSpec ecs a -> ecs -> Int
size (ComponentSpec spec) ecs =
    Dict.size (spec.get ecs)



-- APPLY SELECTORS --


{-| Get a specific set of components of an entity.
-}
select : Selector ecs a -> EntityId -> ecs -> Maybe a
select (Selector selector) (Internal.EntityId entityId) ecs =
    selector.select entityId ecs


{-| Get all entities with a specific set of components.
-}
selectList : Selector ecs a -> ecs -> List ( EntityId, a )
selectList (Selector selector) ecs =
    selector.selectList ecs

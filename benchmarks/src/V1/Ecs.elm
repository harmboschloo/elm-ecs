module V1.Ecs exposing
    ( empty, isEmpty, entityCount, componentCount, ids
    , member, clear
    , has, get, insert, update, remove, size
    , select, selectList
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
import Set exposing (Set)
import V1.Ecs.Internal exposing (ComponentSpec(..), Selector(..), Spec(..))



-- MODEL --


{-| Create an empty ecs.
-}
empty : Spec comparable ecs -> ecs
empty (Spec spec) =
    spec.empty


{-| Determine if the ecs is empty
-}
isEmpty : Spec comparable ecs -> ecs -> Bool
isEmpty (Spec spec) ecs =
    spec.isEmpty ecs


{-| Determine the total number of entities in the ecs.
Warning: this is an expensive operation.
-}
entityCount : Spec comparable ecs -> ecs -> Int
entityCount spec ecs =
    Set.size (ids spec ecs)


{-| Determine the total number of components in the ecs.
-}
componentCount : Spec comparable ecs -> ecs -> Int
componentCount (Spec spec) ecs =
    spec.componentCount ecs


{-| Get all entity ids in the ecs.
Warning: this is an expensive operation.
-}
ids : Spec comparable ecs -> ecs -> Set comparable
ids (Spec spec) ecs =
    spec.ids ecs



-- ENTITY --


{-| Determine if an entity is in the ecs.
-}
member : Spec comparable ecs -> comparable -> ecs -> Bool
member (Spec spec) id ecs =
    spec.member id ecs


{-| Remove all components of an entity.
-}
clear : Spec comparable ecs -> comparable -> ecs -> ecs
clear (Spec spec) id ecs =
    spec.clear id ecs



-- COMPONENTS --


{-| Determines if an entity has a specific component.
-}
has : ComponentSpec comparable ecs a -> comparable -> ecs -> Bool
has (ComponentSpec spec) id ecs =
    Dict.member id (spec.get ecs)


{-| Get a specific component of an entity.
-}
get : ComponentSpec comparable ecs a -> comparable -> ecs -> Maybe a
get (ComponentSpec spec) id ecs =
    Dict.get id (spec.get ecs)


{-| Insert a specific component in an entity.
-}
insert : ComponentSpec comparable ecs a -> comparable -> a -> ecs -> ecs
insert (ComponentSpec spec) id a ecs =
    spec.update (\dict -> Dict.insert id a dict) ecs


{-| Update a specific component in an entity.
-}
update :
    ComponentSpec comparable ecs a
    -> comparable
    -> (Maybe a -> Maybe a)
    -> ecs
    -> ecs
update (ComponentSpec spec) id fn ecs =
    spec.update (\dict -> Dict.update id fn dict) ecs


{-| Remove a specific component from an entity.
-}
remove : ComponentSpec comparable ecs a -> comparable -> ecs -> ecs
remove (ComponentSpec spec) id ecs =
    spec.update (\dict -> Dict.remove id dict) ecs


{-| Determine the total number of components of a specific type.
-}
size : ComponentSpec comparable ecs a -> ecs -> Int
size (ComponentSpec spec) ecs =
    Dict.size (spec.get ecs)



-- APPLY SELECTORS --


{-| Get a specific set of components of an entity.
-}
select : Selector comparable ecs a -> comparable -> ecs -> Maybe a
select (Selector selector) id ecs =
    selector.select id ecs


{-| Get all entities with a specific set of components.
-}
selectList : Selector comparable ecs a -> ecs -> List ( comparable, a )
selectList (Selector selector) ecs =
    selector.selectList ecs

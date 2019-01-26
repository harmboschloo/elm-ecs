module Ecs exposing
    ( empty, isEmpty, entityCount, componentCount, ids
    , member, clear
    , has, get, insert, update, remove, size
    , select, selectList
    , EntityId, World, create, destroy
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


type World data
    = World
        { entities :
            { nextId : Int
            , activeIds : Set Int
            }
        , data : data
        }


{-| Create an empty world.
-}
empty : Spec data -> World data
empty (Spec spec) =
    World
        { entities =
            { -- TODO start at -...?
              nextId = 0
            , activeIds = Set.empty
            }
        , data = spec.empty
        }


{-| Determine if the world is empty
-}
isEmpty : World data -> Bool
isEmpty (World world) =
    Set.isEmpty world.entities.activeIds


{-| Determine the total number of entities in the world.
-}
entityCount : World data -> Int
entityCount (World world) =
    Set.size world.entities.activeIds


{-| Determine the total number of components in the world.
-}
componentCount : Spec data -> World data -> Int
componentCount (Spec spec) (World world) =
    -- TODO track number of components in world?
    spec.size world.data


{-| Get all entity ids in the world.
-}
ids : World data -> List EntityId
ids (World world) =
    world.entities.activeIds
        |> Set.toList
        |> List.map Internal.EntityId



-- ENTITY --


type alias EntityId =
    Internal.EntityId


create : World data -> ( World data, EntityId )
create (World { entities, data }) =
    ( World
        { entities =
            { nextId = entities.nextId + 1
            , activeIds = Set.insert entities.nextId entities.activeIds
            }
        , data = data
        }
    , Internal.EntityId entities.nextId
    )


destroy : Spec data -> EntityId -> World data -> World data
destroy (Spec spec) (Internal.EntityId entityId) (World { entities, data }) =
    World
        { entities =
            { nextId = entities.nextId
            , activeIds = Set.remove entityId entities.activeIds
            }
        , data = spec.clear entityId data
        }


{-| Determine if an entity is in the world.
-}
member : EntityId -> World data -> Bool
member (Internal.EntityId entityId) (World { entities }) =
    Set.member entityId entities.activeIds


{-| Remove all components of an entity.
-}
clear : Spec data -> EntityId -> World data -> World data
clear (Spec spec) (Internal.EntityId entityId) (World { entities, data }) =
    World
        { entities = entities
        , data = spec.clear entityId data
        }



-- COMPONENTS --


{-| Determines if an entity has a specific component.
-}
has : ComponentSpec data a -> EntityId -> World data -> Bool
has (ComponentSpec spec) (Internal.EntityId entityId) (World { data }) =
    Dict.member entityId (spec.get data)


{-| Get a specific component of an entity.
-}
get : ComponentSpec data a -> EntityId -> World data -> Maybe a
get (ComponentSpec spec) (Internal.EntityId entityId) (World { data }) =
    Dict.get entityId (spec.get data)


{-| Insert a specific component in an entity.
-}
insert : ComponentSpec data a -> EntityId -> a -> World data -> World data
insert (ComponentSpec spec) (Internal.EntityId entityId) a (World world) =
    let
        { entities, data } =
            world
    in
    if Set.member entityId entities.activeIds then
        World
            { entities = entities
            , data = spec.update (\dict -> Dict.insert entityId a dict) data
            }

    else
        World world


{-| Update a specific component in an entity.
-}
update :
    ComponentSpec data a
    -> EntityId
    -> (Maybe a -> Maybe a)
    -> World data
    -> World data
update (ComponentSpec spec) (Internal.EntityId entityId) fn (World world) =
    let
        { entities, data } =
            world
    in
    if Set.member entityId entities.activeIds then
        World
            { entities = entities
            , data = spec.update (\dict -> Dict.update entityId fn dict) data
            }

    else
        World world


{-| Remove a specific component from an entity.
-}
remove : ComponentSpec data a -> EntityId -> World data -> World data
remove (ComponentSpec spec) (Internal.EntityId entityId) (World { entities, data }) =
    World
        { entities = entities
        , data = spec.update (\dict -> Dict.remove entityId dict) data
        }


{-| Determine the total number of components of a specific type.
-}
size : ComponentSpec data a -> World data -> Int
size (ComponentSpec spec) (World { data }) =
    Dict.size (spec.get data)



-- APPLY SELECTORS --


{-| Get a specific set of components of an entity.
-}
select : Selector data a -> EntityId -> World data -> Maybe a
select (Selector selector) (Internal.EntityId entityId) (World { data }) =
    selector.select entityId data


{-| Get all entities with a specific set of components.
-}
selectList : Selector data a -> World data -> List ( EntityId, a )
selectList (Selector selector) (World { data }) =
    selector.selectList data

module V2a_Entities.Ecs exposing
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
import Set exposing (Set)
import V2a_Entities.Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , Selector(..)
        , Spec(..)
        )



-- MODEL --


type World components
    = World
        { entities :
            { nextId : Int
            , activeIds : Set Int
            }
        , components : components
        }


{-| Create an empty world.
-}
empty : Spec components -> World components
empty (Spec spec) =
    World
        { entities =
            { -- TODO start at -...?
              nextId = 0
            , activeIds = Set.empty
            }
        , components = spec.empty
        }


{-| Determine if the world is empty
-}
isEmpty : World components -> Bool
isEmpty (World world) =
    Set.isEmpty world.entities.activeIds


{-| Determine the total number of entities in the world.
-}
entityCount : World components -> Int
entityCount (World world) =
    Set.size world.entities.activeIds


{-| Determine the total number of components in the world.
-}
componentCount : Spec components -> World components -> Int
componentCount (Spec spec) (World world) =
    -- TODO track number of components in world?
    spec.size world.components


{-| Get all entity ids in the world.
-}
ids : World components -> List EntityId
ids (World world) =
    world.entities.activeIds
        |> Set.toList
        |> List.map Internal.EntityId



-- ENTITY --


type alias EntityId =
    Internal.EntityId


create : World components -> ( World components, EntityId )
create (World { entities, components }) =
    ( World
        { entities =
            { nextId = entities.nextId + 1
            , activeIds = Set.insert entities.nextId entities.activeIds
            }
        , components = components
        }
    , Internal.EntityId entities.nextId
    )


destroy : Spec components -> EntityId -> World components -> World components
destroy (Spec spec) (Internal.EntityId entityId) (World { entities, components }) =
    World
        { entities =
            { nextId = entities.nextId
            , activeIds = Set.remove entityId entities.activeIds
            }
        , components = spec.clear entityId components
        }


{-| Determine if an entity is in the world.
-}
member : EntityId -> World components -> Bool
member (Internal.EntityId entityId) (World { entities }) =
    Set.member entityId entities.activeIds


{-| Remove all components of an entity.
-}
clear : Spec components -> EntityId -> World components -> World components
clear (Spec spec) (Internal.EntityId entityId) (World { entities, components }) =
    World
        { entities = entities
        , components = spec.clear entityId components
        }



-- COMPONENTS --


{-| Determines if an entity has a specific component.
-}
has : ComponentSpec components a -> EntityId -> World components -> Bool
has (ComponentSpec spec) (Internal.EntityId entityId) (World { components }) =
    Dict.member entityId (spec.get components)


{-| Get a specific component of an entity.
-}
get : ComponentSpec components a -> EntityId -> World components -> Maybe a
get (ComponentSpec spec) (Internal.EntityId entityId) (World { components }) =
    Dict.get entityId (spec.get components)


{-| Insert a specific component in an entity.
-}
insert :
    ComponentSpec components a
    -> EntityId
    -> a
    -> World components
    -> World components
insert (ComponentSpec spec) (Internal.EntityId entityId) a (World world) =
    let
        { entities, components } =
            world
    in
    if Set.member entityId entities.activeIds then
        World
            { entities = entities
            , components =
                spec.update (\dict -> Dict.insert entityId a dict) components
            }

    else
        World world


{-| Update a specific component in an entity.
-}
update :
    ComponentSpec components a
    -> EntityId
    -> (Maybe a -> Maybe a)
    -> World components
    -> World components
update (ComponentSpec spec) (Internal.EntityId entityId) fn (World world) =
    let
        { entities, components } =
            world
    in
    if Set.member entityId entities.activeIds then
        World
            { entities = entities
            , components =
                spec.update (\dict -> Dict.update entityId fn dict) components
            }

    else
        World world


{-| Remove a specific component from an entity.
-}
remove :
    ComponentSpec components a
    -> EntityId
    -> World components
    -> World components
remove (ComponentSpec spec) (Internal.EntityId entityId) (World { entities, components }) =
    World
        { entities = entities
        , components = spec.update (\dict -> Dict.remove entityId dict) components
        }


{-| Determine the total number of components of a specific type.
-}
size : ComponentSpec components a -> World components -> Int
size (ComponentSpec spec) (World { components }) =
    Dict.size (spec.get components)



-- APPLY SELECTORS --


{-| Get a specific set of components of an entity.
-}
select : Selector components a -> EntityId -> World components -> Maybe a
select (Selector selector) (Internal.EntityId entityId) (World { components }) =
    selector.select entityId components


{-| Get all entities with a specific set of components.
-}
selectList : Selector components a -> World components -> List ( EntityId, a )
selectList (Selector selector) (World { components }) =
    selector.selectList components

module V2c_DictIntersect.Ecs exposing
    ( World, emptyWorld, isEmptyWorld, worldEntityIds
    , worldEntityCount, worldComponentCount
    , EntityId
    , createEntity, hasEntity, clearEntity, destroyEntity
    , hasComponent, getComponent, insertComponent, updateComponent, removeComponent
    , componentCount
    , andInsertComponent, andUpdateComponent
    , getSingleton, setSingleton, updateSingleton
    , foldr, foldr2, foldr3
    )

{-|


# World

@docs World, emptyWorld, isEmptyWorld, worldEntityIds
@docs worldEntityCount, worldComponentCount


# Entity

@docs EntityId
@docs createEntity, hasEntity, clearEntity, destroyEntity


# Component

@docs hasComponent, getComponent, insertComponent, updateComponent, removeComponent
@docs componentCount


# Component Pipeline

@docs andInsertComponent, andUpdateComponent


# Singletons

@docs getSingleton, setSingleton, updateSingleton


# Apply Selectors

@docs select, selectAll, processAll

-}

import Dict
import Dict.Intersect
import Set exposing (Set)
import V2c_DictIntersect.Ecs.Internal as Internal
    exposing
        ( AllComponentsSpec(..)
        , ComponentSpec(..)
        , SingletonSpec(..)
        )



-- WORLD --


type World components singletons
    = World
        { entities :
            { nextId : Int
            , activeIds : Set Int
            }
        , components : components
        , singletons : singletons
        }


{-| Create an empty world without entities or components.
-}
emptyWorld : AllComponentsSpec components -> singletons -> World components singletons
emptyWorld (AllComponentsSpec componentsSpec) singletons =
    World
        { singletons = singletons
        , entities =
            { nextId = 0
            , activeIds = Set.empty
            }
        , components = componentsSpec.empty
        }


{-| Determine if the world is empty, without entities or components.
-}
isEmptyWorld : World components singletons -> Bool
isEmptyWorld (World world) =
    Set.isEmpty world.entities.activeIds


{-| Determine the total number of entities in the world.
-}
worldEntityCount : World components singletons -> Int
worldEntityCount (World world) =
    Set.size world.entities.activeIds


{-| Determine the total number of components in the world.
-}
worldComponentCount :
    AllComponentsSpec components
    -> World components singletons
    -> Int
worldComponentCount (AllComponentsSpec spec) (World world) =
    spec.size world.components


{-| Get all entity ids in the world.
-}
worldEntityIds : World components singletons -> List EntityId
worldEntityIds (World world) =
    world.entities.activeIds
        |> Set.toList
        |> List.map Internal.EntityId



-- ENTITY --


type alias EntityId =
    Internal.EntityId


createEntity :
    World components singletons
    -> ( EntityId, World components singletons )
createEntity (World { entities, components, singletons }) =
    ( Internal.EntityId entities.nextId
    , World
        { entities =
            { nextId = entities.nextId + 1
            , activeIds = Set.insert entities.nextId entities.activeIds
            }
        , components = components
        , singletons = singletons
        }
    )


destroyEntity :
    AllComponentsSpec components
    -> EntityId
    -> World components singletons
    -> World components singletons
destroyEntity (AllComponentsSpec spec) (Internal.EntityId entityId) (World world) =
    World
        { entities =
            { nextId = world.entities.nextId
            , activeIds = Set.remove entityId world.entities.activeIds
            }
        , components = spec.clear entityId world.components
        , singletons = world.singletons
        }


{-| Determine if an entity is in the world.
-}
hasEntity : EntityId -> World components singletons -> Bool
hasEntity (Internal.EntityId entityId) (World { entities }) =
    Set.member entityId entities.activeIds


{-| Remove all components of an entity.
-}
clearEntity :
    AllComponentsSpec components
    -> EntityId
    -> World components singletons
    -> World components singletons
clearEntity (AllComponentsSpec spec) (Internal.EntityId entityId) (World world) =
    World
        { entities = world.entities
        , components = spec.clear entityId world.components
        , singletons = world.singletons
        }



-- COMPONENTS --


{-| Determines if an entity has a specific component.
-}
hasComponent :
    ComponentSpec components a
    -> EntityId
    -> World components singletons
    -> Bool
hasComponent (ComponentSpec spec) (Internal.EntityId entityId) (World { components }) =
    Dict.member entityId (spec.get components)


{-| Get a specific component of an entity.
-}
getComponent :
    ComponentSpec components a
    -> EntityId
    -> World components singletons
    -> Maybe a
getComponent (ComponentSpec spec) (Internal.EntityId entityId) (World { components }) =
    Dict.get entityId (spec.get components)


{-| Insert a specific component in an entity.
-}
insertComponent :
    ComponentSpec components a
    -> EntityId
    -> a
    -> World components singletons
    -> World components singletons
insertComponent (ComponentSpec spec) (Internal.EntityId entityId) a (World world) =
    if Set.member entityId world.entities.activeIds then
        World
            { entities = world.entities
            , components =
                spec.set
                    (Dict.insert entityId a (spec.get world.components))
                    world.components
            , singletons = world.singletons
            }

    else
        World world


{-| Update a specific component in an entity.
-}
updateComponent :
    ComponentSpec components a
    -> EntityId
    -> (Maybe a -> Maybe a)
    -> World components singletons
    -> World components singletons
updateComponent (ComponentSpec spec) (Internal.EntityId entityId) fn (World world) =
    if Set.member entityId world.entities.activeIds then
        World
            { entities = world.entities
            , components =
                spec.set
                    (Dict.update entityId fn (spec.get world.components))
                    world.components
            , singletons = world.singletons
            }

    else
        World world


{-| Remove a specific component from an entity.
-}
removeComponent :
    ComponentSpec components a
    -> EntityId
    -> World components singletons
    -> World components singletons
removeComponent (ComponentSpec spec) (Internal.EntityId entityId) (World world) =
    World
        { entities = world.entities
        , components =
            spec.set
                (Dict.remove entityId (spec.get world.components))
                world.components
        , singletons = world.singletons
        }


{-| Determine the total number of components of a specific type.
-}
componentCount : ComponentSpec components a -> World components singletons -> Int
componentCount (ComponentSpec spec) (World { components }) =
    Dict.size (spec.get components)



-- COMPONENTS PIPELINE --


{-| Insert a specific component in an entity.
-}
andInsertComponent :
    ComponentSpec components a
    -> a
    -> ( EntityId, World components singletons )
    -> ( EntityId, World components singletons )
andInsertComponent spec a ( entityId, world ) =
    ( entityId, insertComponent spec entityId a world )


{-| Update a specific component in an entity.
-}
andUpdateComponent :
    ComponentSpec components a
    -> (Maybe a -> Maybe a)
    -> ( EntityId, World components singletons )
    -> ( EntityId, World components singletons )
andUpdateComponent spec fn ( entityId, world ) =
    ( entityId, updateComponent spec entityId fn world )



-- SINGLETON COMPONENTS --


getSingleton : SingletonSpec singletons a -> World components singletons -> a
getSingleton (SingletonSpec spec) (World { singletons }) =
    spec.get singletons


setSingleton :
    SingletonSpec singletons a
    -> a
    -> World components singletons
    -> World components singletons
setSingleton spec a =
    updateSingleton spec (always a)


updateSingleton :
    SingletonSpec singletons a
    -> (a -> a)
    -> World components singletons
    -> World components singletons
updateSingleton (SingletonSpec spec) fn (World world) =
    World
        { entities = world.entities
        , components = world.components
        , singletons = spec.set (fn (spec.get world.singletons)) world.singletons
        }



---


foldr :
    ComponentSpec components a
    -> (EntityId -> a -> acc -> acc)
    -> acc
    -> World components singletons
    -> acc
foldr (ComponentSpec spec) fn acc (World world) =
    Dict.foldr
        (\entityId a x -> fn (Internal.EntityId entityId) a x)
        acc
        (spec.get world.components)


foldr2 :
    ComponentSpec components a1
    -> ComponentSpec components a2
    -> (EntityId -> a1 -> a2 -> acc -> acc)
    -> acc
    -> World components singletons
    -> acc
foldr2 (ComponentSpec spec1) (ComponentSpec spec2) fn acc (World world) =
    Dict.Intersect.foldr2
        (\entityId a1 a2 x -> fn (Internal.EntityId entityId) a1 a2 x)
        acc
        (spec1.get world.components)
        (spec2.get world.components)


foldr3 :
    ComponentSpec components a1
    -> ComponentSpec components a2
    -> ComponentSpec components a3
    -> (EntityId -> a1 -> a2 -> a3 -> acc -> acc)
    -> acc
    -> World components singletons
    -> acc
foldr3 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn acc (World world) =
    Dict.Intersect.foldr3
        (\entityId a1 a2 a3 x -> fn (Internal.EntityId entityId) a1 a2 a3 x)
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)

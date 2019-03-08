module Ecs exposing
    ( MultiComponentSpec, ComponentSpec, SingletonSpec
    , World, emptyWorld, isEmptyWorld, worldEntityIds
    , worldEntityCount, worldComponentCount
    , insertEntity, removeEntity, clearEntity, hasEntity
    , insertComponent, updateComponent, removeComponent
    , hasComponent, getComponent, componentCount
    , andInsertEntity, andInsertComponent, andUpdateComponent
    , setSingleton, updateSingleton, updateSingletonAndReturn, getSingleton
    )

{-|


# Specs

@docs MultiComponentSpec, ComponentSpec, SingletonSpec


# World

@docs World, emptyWorld, isEmptyWorld, worldEntityIds
@docs worldEntityCount, worldComponentCount


# Entity

@docs insertEntity, removeEntity, clearEntity, hasEntity


# Component

@docs insertComponent, updateComponent, removeComponent
@docs hasComponent, getComponent, componentCount


# Pipelines

@docs andInsertEntity, andInsertComponent, andUpdateComponent


# Singletons

@docs setSingleton, updateSingleton, updateSingletonAndReturn, getSingleton

-}

import Dict
import Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , MultiComponentSpec(..)
        , SingletonSpec(..)
        , World(..)
        )
import Set exposing (Set)



-- SPECS --


type alias MultiComponentSpec comparable components =
    Internal.MultiComponentSpec comparable components


type alias ComponentSpec comparable a components =
    Internal.ComponentSpec comparable a components


type alias SingletonSpec a singletons =
    Internal.SingletonSpec a singletons



-- WORLD --


type alias World comparable components singletons =
    Internal.World comparable components singletons


{-| Create an empty world without entities or components.
-}
emptyWorld :
    MultiComponentSpec comparable components
    -> singletons
    -> World comparable components singletons
emptyWorld (MultiComponentSpec componentsSpec) singletons =
    World
        { singletons = singletons
        , entities = Set.empty
        , components = componentsSpec.empty
        }


{-| Determine if the world is empty, without entities or components.
-}
isEmptyWorld : World comparable components singletons -> Bool
isEmptyWorld (World world) =
    Set.isEmpty world.entities


{-| Determine the total number of entities in the world.
-}
worldEntityCount : World comparable components singletons -> Int
worldEntityCount (World world) =
    Set.size world.entities


{-| Determine the total number of components in the world.
-}
worldComponentCount :
    MultiComponentSpec comparable components
    -> World comparable components singletons
    -> Int
worldComponentCount (MultiComponentSpec spec) (World world) =
    spec.size world.components


{-| Get all entity ids in the world.
-}
worldEntityIds : World comparable components singletons -> List comparable
worldEntityIds (World world) =
    Set.toList world.entities



-- ENTITY --


insertEntity :
    comparable
    -> World comparable components singletons
    -> World comparable components singletons
insertEntity entityId (World { entities, components, singletons }) =
    World
        { entities = Set.insert entityId entities
        , components = components
        , singletons = singletons
        }


removeEntity :
    MultiComponentSpec comparable components
    -> comparable
    -> World comparable components singletons
    -> World comparable components singletons
removeEntity (MultiComponentSpec spec) entityId (World { entities, components, singletons }) =
    World
        { entities = Set.remove entityId entities
        , components = spec.clear entityId components
        , singletons = singletons
        }


{-| Determine if an entity is in the world.
-}
hasEntity : comparable -> World comparable components singletons -> Bool
hasEntity entityId (World { entities }) =
    Set.member entityId entities


{-| Remove all components of an entity.
-}
clearEntity :
    MultiComponentSpec comparable components
    -> comparable
    -> World comparable components singletons
    -> World comparable components singletons
clearEntity (MultiComponentSpec spec) entityId (World world) =
    World
        { entities = world.entities
        , components = spec.clear entityId world.components
        , singletons = world.singletons
        }



-- COMPONENTS --


{-| Determines if an entity has a specific component.
-}
hasComponent :
    ComponentSpec comparable a components
    -> comparable
    -> World comparable components singletons
    -> Bool
hasComponent (ComponentSpec spec) entityId (World { components }) =
    Dict.member entityId (spec.get components)


{-| Get a specific component of an entity.
-}
getComponent :
    ComponentSpec comparable a components
    -> comparable
    -> World comparable components singletons
    -> Maybe a
getComponent (ComponentSpec spec) entityId (World { components }) =
    Dict.get entityId (spec.get components)


{-| Insert a specific component in an entity.
-}
insertComponent :
    ComponentSpec comparable a components
    -> comparable
    -> a
    -> World comparable components singletons
    -> World comparable components singletons
insertComponent (ComponentSpec spec) entityId a (World world) =
    if Set.member entityId world.entities then
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
    ComponentSpec comparable a components
    -> comparable
    -> (Maybe a -> Maybe a)
    -> World comparable components singletons
    -> World comparable components singletons
updateComponent (ComponentSpec spec) entityId fn (World world) =
    if Set.member entityId world.entities then
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
    ComponentSpec comparable a components
    -> comparable
    -> World comparable components singletons
    -> World comparable components singletons
removeComponent (ComponentSpec spec) entityId (World world) =
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
componentCount :
    ComponentSpec comparable a components
    -> World comparable components singletons
    -> Int
componentCount (ComponentSpec spec) (World { components }) =
    Dict.size (spec.get components)



-- COMPONENTS PIPELINE --


{-| Insert a specific component in an entity.
-}
andInsertEntity :
    ( World comparable components singletons, comparable )
    -> ( World comparable components singletons, comparable )
andInsertEntity ( world, entityId ) =
    ( insertEntity entityId world, entityId )


{-| Insert a specific component in an entity.
-}
andInsertComponent :
    ComponentSpec comparable a components
    -> a
    -> ( World comparable components singletons, comparable )
    -> ( World comparable components singletons, comparable )
andInsertComponent spec a ( world, entityId ) =
    ( insertComponent spec entityId a world, entityId )


{-| Update a specific component in an entity.
-}
andUpdateComponent :
    ComponentSpec comparable a components
    -> (Maybe a -> Maybe a)
    -> ( World comparable components singletons, comparable )
    -> ( World comparable components singletons, comparable )
andUpdateComponent spec fn ( world, entityId ) =
    ( updateComponent spec entityId fn world, entityId )



-- SINGLETON COMPONENTS --


getSingleton :
    SingletonSpec a singletons
    -> World comparable components singletons
    -> a
getSingleton (SingletonSpec spec) (World { singletons }) =
    spec.get singletons


setSingleton :
    SingletonSpec a singletons
    -> a
    -> World comparable components singletons
    -> World comparable components singletons
setSingleton spec a =
    updateSingleton spec (always a)


updateSingleton :
    SingletonSpec a singletons
    -> (a -> a)
    -> World comparable components singletons
    -> World comparable components singletons
updateSingleton (SingletonSpec spec) fn (World world) =
    World
        { entities = world.entities
        , components = world.components
        , singletons = spec.set (fn (spec.get world.singletons)) world.singletons
        }


updateSingletonAndReturn :
    SingletonSpec a singletons
    -> (a -> a)
    -> World comparable components singletons
    -> ( World comparable components singletons, a )
updateSingletonAndReturn (SingletonSpec spec) fn (World world) =
    let
        aNew =
            fn (spec.get world.singletons)
    in
    ( World
        { entities = world.entities
        , components = world.components
        , singletons = spec.set aNew world.singletons
        }
    , aNew
    )

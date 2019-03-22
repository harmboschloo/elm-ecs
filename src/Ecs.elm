module Ecs exposing
    ( AllComponentSpec, ComponentSpec, SingletonSpec
    , World, emptyWorld, isEmptyWorld, worldEntities
    , worldEntityCount, worldComponentCount
    , insertEntity, onEntity, removeEntity, clearEntity, hasEntity, getEntity
    , insertComponent, updateComponent, removeComponent
    , hasComponent, getComponent, componentEntities, componentCount
    , fromDict, toDict
    , setSingleton, updateSingleton, getSingleton
    )

{-|


# Specs

@docs AllComponentSpec, ComponentSpec, SingletonSpec


# World

@docs World, emptyWorld, isEmptyWorld, worldEntities
@docs worldEntityCount, worldComponentCount


# Entity

@docs insertEntity, onEntity, removeEntity, clearEntity, hasEntity, getEntity


# Component

@docs insertComponent, updateComponent, removeComponent
@docs hasComponent, getComponent, componentEntities, componentCount
@docs fromDict, toDict


# Singletons

@docs setSingleton, updateSingleton, updateSingletonAndReturn, getSingleton

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
    exposing
        ( AllComponentSpec(..)
        , ComponentSpec(..)
        , SingletonSpec(..)
        , World(..)
        )
import Set exposing (Set)



-- SPECS --


{-| -}
type alias AllComponentSpec comparable components =
    Internal.AllComponentSpec comparable components


{-| -}
type alias ComponentSpec comparable a components =
    Internal.ComponentSpec comparable a components


{-| -}
type alias SingletonSpec a singletons =
    Internal.SingletonSpec a singletons



-- WORLD --


{-| -}
type alias World comparable components singletons =
    Internal.World comparable components singletons


{-| Create an empty world without entities or components.
-}
emptyWorld :
    AllComponentSpec comparable components
    -> singletons
    -> World comparable components singletons
emptyWorld (AllComponentSpec componentsSpec) singletons =
    World
        { entities = Set.empty
        , activeEntity = Nothing
        , components = componentsSpec.empty
        , singletons = singletons
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
    AllComponentSpec comparable components
    -> World comparable components singletons
    -> Int
worldComponentCount (AllComponentSpec spec) (World world) =
    spec.size world.components


{-| Get all entity ids in the world.
-}
worldEntities : World comparable components singletons -> Set comparable
worldEntities (World world) =
    world.entities



-- ENTITY --


{-| -}
insertEntity :
    comparable
    -> World comparable components singletons
    -> World comparable components singletons
insertEntity entityId (World { entities, components, singletons }) =
    World
        { entities = Set.insert entityId entities
        , activeEntity = Just entityId
        , components = components
        , singletons = singletons
        }


{-| -}
onEntity :
    comparable
    -> World comparable components singletons
    -> World comparable components singletons
onEntity entityId (World { entities, components, singletons }) =
    World
        { entities = entities
        , activeEntity =
            if Set.member entityId entities then
                Just entityId

            else
                Nothing
        , components = components
        , singletons = singletons
        }


{-| -}
getEntity : World comparable components singletons -> Maybe comparable
getEntity (World { activeEntity }) =
    activeEntity


{-| -}
hasEntity : World comparable components singletons -> Bool
hasEntity (World { activeEntity }) =
    activeEntity /= Nothing


{-| -}
removeEntity :
    AllComponentSpec comparable components
    -> World comparable components singletons
    -> World comparable components singletons
removeEntity (AllComponentSpec spec) (World world) =
    case world.activeEntity of
        Just entityId ->
            World
                { entities = Set.remove entityId world.entities
                , activeEntity = Nothing
                , components = spec.clear entityId world.components
                , singletons = world.singletons
                }

        Nothing ->
            World world


{-| Remove all components of an entity.
-}
clearEntity :
    AllComponentSpec comparable components
    -> World comparable components singletons
    -> World comparable components singletons
clearEntity (AllComponentSpec spec) (World world) =
    case world.activeEntity of
        Just entityId ->
            World
                { entities = world.entities
                , activeEntity = world.activeEntity
                , components = spec.clear entityId world.components
                , singletons = world.singletons
                }

        Nothing ->
            World world



-- COMPONENTS --


{-| Determines if an entity has a specific component.
-}
hasComponent :
    ComponentSpec comparable a components
    -> World comparable components singletons
    -> Bool
hasComponent (ComponentSpec spec) (World world) =
    case world.activeEntity of
        Just entityId ->
            Dict.member entityId (spec.get world.components)

        Nothing ->
            False


{-| Get a specific component of an entity.
-}
getComponent :
    ComponentSpec comparable a components
    -> World comparable components singletons
    -> Maybe a
getComponent (ComponentSpec spec) (World world) =
    case world.activeEntity of
        Just entityId ->
            Dict.get entityId (spec.get world.components)

        Nothing ->
            Nothing


{-| Insert a specific component in an entity.
-}
insertComponent :
    ComponentSpec comparable a components
    -> a
    -> World comparable components singletons
    -> World comparable components singletons
insertComponent (ComponentSpec spec) a (World world) =
    case world.activeEntity of
        Just entityId ->
            World
                { entities = world.entities
                , activeEntity = world.activeEntity
                , components =
                    spec.set
                        (Dict.insert entityId a (spec.get world.components))
                        world.components
                , singletons = world.singletons
                }

        Nothing ->
            World world


{-| Update a specific component in an entity.
-}
updateComponent :
    ComponentSpec comparable a components
    -> (Maybe a -> Maybe a)
    -> World comparable components singletons
    -> World comparable components singletons
updateComponent (ComponentSpec spec) fn (World world) =
    case world.activeEntity of
        Just entityId ->
            World
                { entities = world.entities
                , activeEntity = world.activeEntity
                , components =
                    spec.set
                        (Dict.update entityId fn (spec.get world.components))
                        world.components
                , singletons = world.singletons
                }

        Nothing ->
            World world


{-| Remove a specific component from an entity.
-}
removeComponent :
    ComponentSpec comparable a components
    -> World comparable components singletons
    -> World comparable components singletons
removeComponent (ComponentSpec spec) (World world) =
    case world.activeEntity of
        Just entityId ->
            World
                { entities = world.entities
                , activeEntity = world.activeEntity
                , components =
                    spec.set
                        (Dict.remove entityId (spec.get world.components))
                        world.components
                , singletons = world.singletons
                }

        Nothing ->
            World world


{-| -}
componentEntities :
    ComponentSpec comparable a components
    -> World comparable components singletons
    -> Set comparable
componentEntities (ComponentSpec spec) (World { components }) =
    Dict.foldl
        (\entityId _ -> Set.insert entityId)
        Set.empty
        (spec.get components)


{-| Determine the total number of components of a specific type.
-}
componentCount :
    ComponentSpec comparable a components
    -> World comparable components singletons
    -> Int
componentCount (ComponentSpec spec) (World { components }) =
    Dict.size (spec.get components)


{-| -}
fromDict :
    ComponentSpec comparable a components
    -> Dict comparable a
    -> World comparable components singletons
    -> World comparable components singletons
fromDict (ComponentSpec spec) dict (World world) =
    World
        { entities =
            Dict.foldl
                (\entityId _ -> Set.insert entityId)
                world.entities
                dict
        , activeEntity = world.activeEntity
        , components = spec.set dict world.components
        , singletons = world.singletons
        }


{-| -}
toDict :
    ComponentSpec comparable a components
    -> World comparable components singletons
    -> Dict comparable a
toDict (ComponentSpec spec) (World { components }) =
    spec.get components



-- SINGLETON COMPONENTS --


{-| -}
getSingleton :
    SingletonSpec a singletons
    -> World comparable components singletons
    -> a
getSingleton (SingletonSpec spec) (World { singletons }) =
    spec.get singletons


{-| -}
setSingleton :
    SingletonSpec a singletons
    -> a
    -> World comparable components singletons
    -> World comparable components singletons
setSingleton spec a =
    updateSingleton spec (always a)


{-| -}
updateSingleton :
    SingletonSpec a singletons
    -> (a -> a)
    -> World comparable components singletons
    -> World comparable components singletons
updateSingleton (SingletonSpec spec) fn (World world) =
    World
        { entities = world.entities
        , activeEntity = world.activeEntity
        , components = world.components
        , singletons =
            spec.set
                (fn (spec.get world.singletons))
                world.singletons
        }

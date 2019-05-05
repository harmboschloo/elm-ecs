module Ecs exposing
    ( AllComponentsSpec, ComponentSpec, SingletonSpec
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

Specs specify how to retrieve and update components and singletons.
They are initialized using the **Ecs.ComponentsN** and **Ecs.SingletonsN** modules.

    type alias Specs =
        { allComponents : AllComponentsSpec EntityId Components
        , position : ComponentSpec EntityId Position Components
        , velocity : ComponentSpec EntityId Velocity Components
        , nextEntityId : SingletonSpec EntityId Singletons
        }

    specs : Specs
    specs =
        Specs |> Ecs.Components2.specs |> Ecs.Singletons1.specs

@docs AllComponentsSpec, ComponentSpec, SingletonSpec


# World

The world contains all your entities, components and singletons.

@docs World, emptyWorld, isEmptyWorld, worldEntities
@docs worldEntityCount, worldComponentCount


# Entity

Entities are represented by an id.
An entity id can be any [`comparable` type](https://faq.elm-community.org/#does-elm-have-ad-hoc-polymorphism-or-typeclasses).

Operations on entities usually apply to the active entity in the world.
You can make an entity active with the [**onEntiy**](#onEntity) function.
Also when you insert a new entity that entity will be active.

@docs insertEntity, onEntity, removeEntity, clearEntity, hasEntity, getEntity


# Component

Components contain all the entity data in the world.
Every component is associated with an entity.

@docs insertComponent, updateComponent, removeComponent
@docs hasComponent, getComponent, componentEntities, componentCount
@docs fromDict, toDict


# Singletons

Singletons contain data where there should only be one instance of.
Singletons are optional. They are added to the package for convenience
and to create a consistent way to deal with data (singletons and components).
You can also just keep the singleton data in your model next to the ecs world just like you do in any Elm program.

@docs setSingleton, updateSingleton, getSingleton

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
    exposing
        ( AllComponentsSpec(..)
        , ComponentSpec(..)
        , SingletonSpec(..)
        , World(..)
        )
import Set exposing (Set)



-- SPECS --


{-| Used for operations on multiple component types.
-}
type alias AllComponentsSpec comparable components =
    Internal.AllComponentsSpec comparable components


{-| Used for operations on a single component type.
-}
type alias ComponentSpec comparable a components =
    Internal.ComponentSpec comparable a components


{-| Used for operations on a single singleton type.
-}
type alias SingletonSpec a singletons =
    Internal.SingletonSpec a singletons



-- WORLD --


{-| The world that contains all you data.
-}
type alias World comparable components singletons =
    Internal.World comparable components singletons


{-| Create an empty world without entities or components.
Singletons need an intial value.
-}
emptyWorld :
    AllComponentsSpec comparable components
    -> singletons
    -> World comparable components singletons
emptyWorld (AllComponentsSpec componentsSpec) singletons =
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
    AllComponentsSpec comparable components
    -> World comparable components singletons
    -> Int
worldComponentCount (AllComponentsSpec spec) (World world) =
    spec.size world.components


{-| Get all entity ids in the world.
-}
worldEntities : World comparable components singletons -> Set comparable
worldEntities (World world) =
    world.entities



-- ENTITY --


{-| Add a new entity id to the world and make the entity active.
-}
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


{-| Make an entity active if it is part of the world, otherwise no entity will be active.
-}
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


{-| Get the active entity id.
-}
getEntity : World comparable components singletons -> Maybe comparable
getEntity (World { activeEntity }) =
    activeEntity


{-| Determine if there is an active entity.
-}
hasEntity : World comparable components singletons -> Bool
hasEntity (World { activeEntity }) =
    activeEntity /= Nothing


{-| Remove the active entity from the world.
All component associated with the entity will also be removed.
-}
removeEntity :
    AllComponentsSpec comparable components
    -> World comparable components singletons
    -> World comparable components singletons
removeEntity (AllComponentsSpec spec) (World world) =
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


{-| Remove all components of the active entity.
The entity will remain part of the world.
-}
clearEntity :
    AllComponentsSpec comparable components
    -> World comparable components singletons
    -> World comparable components singletons
clearEntity (AllComponentsSpec spec) (World world) =
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


{-| Determine if the active entity has the specified component type.
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


{-| Get a component with the specified component type of the active entity.
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


{-| Insert a component with the specified component type in the active entity.
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


{-| Update a component with the specified component type in the active entity.
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


{-| Remove a component with the specified component type from the active entity.
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


{-| Get all entities that contain the specified component type.
-}
componentEntities :
    ComponentSpec comparable a components
    -> World comparable components singletons
    -> Set comparable
componentEntities (ComponentSpec spec) (World { components }) =
    Dict.foldl
        (\entityId _ -> Set.insert entityId)
        Set.empty
        (spec.get components)


{-| Determine the total number of components of the specified component type.
-}
componentCount :
    ComponentSpec comparable a components
    -> World comparable components singletons
    -> Int
componentCount (ComponentSpec spec) (World { components }) =
    Dict.size (spec.get components)


{-| Replaces all components for the specified component type.
All provided entities will be added to the world.
-}
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


{-| Get all components for the specified component type.
-}
toDict :
    ComponentSpec comparable a components
    -> World comparable components singletons
    -> Dict comparable a
toDict (ComponentSpec spec) (World { components }) =
    spec.get components



-- SINGLETON COMPONENTS --


{-| Get the data for the specified singleton type.
-}
getSingleton :
    SingletonSpec a singletons
    -> World comparable components singletons
    -> a
getSingleton (SingletonSpec spec) (World { singletons }) =
    spec.get singletons


{-| Set the data for the specified singleton type.
-}
setSingleton :
    SingletonSpec a singletons
    -> a
    -> World comparable components singletons
    -> World comparable components singletons
setSingleton spec a =
    updateSingleton spec (always a)


{-| Update the data for the specified singleton type.
-}
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

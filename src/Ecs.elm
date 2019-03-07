module Ecs exposing
    ( World, emptyWorld, isEmptyWorld, worldEntityIds
    , worldEntityCount, worldComponentCount
    , insertEntity, removeEntity, clearEntity, hasEntity
    , insertComponent, updateComponent, removeComponent
    , hasComponent, getComponent, componentCount
    , foldEntityComponentsFromFront, foldEntityComponentsFromBack
    , foldEntityComponentsFromFront2, foldEntityComponentsFromBack2
    , foldEntityComponentsFromFront3, foldEntityComponentsFromBack3
    , foldEntityComponentsFromFront4, foldEntityComponentsFromBack4
    , foldEntityComponentsFromFront5, foldEntityComponentsFromBack5
    , foldEntityComponentsFromFront6, foldEntityComponentsFromBack6
    , foldEntityComponentsFromFront7, foldEntityComponentsFromBack7
    , foldEntityComponentsFromFront8, foldEntityComponentsFromBack8
    , setSingleton, updateSingleton, getSingleton
    )

{-|


# World

@docs World, emptyWorld, isEmptyWorld, worldEntityIds
@docs worldEntityCount, worldComponentCount


# Entity

@docs insertEntity, removeEntity, clearEntity, hasEntity


# Component

@docs insertComponent, updateComponent, removeComponent
@docs hasComponent, getComponent, componentCount


# Entity Component Intersections

@docs foldEntityComponentsFromFront, foldEntityComponentsFromBack
@docs foldEntityComponentsFromFront2, foldEntityComponentsFromBack2
@docs foldEntityComponentsFromFront3, foldEntityComponentsFromBack3
@docs foldEntityComponentsFromFront4, foldEntityComponentsFromBack4
@docs foldEntityComponentsFromFront5, foldEntityComponentsFromBack5
@docs foldEntityComponentsFromFront6, foldEntityComponentsFromBack6
@docs foldEntityComponentsFromFront7, foldEntityComponentsFromBack7
@docs foldEntityComponentsFromFront8, foldEntityComponentsFromBack8


# Singletons

@docs setSingleton, updateSingleton, getSingleton

-}

import Dict
import Dict.Intersect
import Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , MultiComponentSpec(..)
        , SingletonSpec(..)
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


type World comparable components singletons
    = World
        { entities : Set comparable
        , components : components
        , singletons : singletons
        }


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



-- ENTITY COMPONENTS INTERSECTIONS --


foldEntityComponentsFromFront :
    ComponentSpec comparable a components
    -> (comparable -> a -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromFront (ComponentSpec spec) fn acc (World world) =
    Dict.foldl
        fn
        acc
        (spec.get world.components)


foldEntityComponentsFromBack :
    ComponentSpec comparable a components
    -> (comparable -> a -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromBack (ComponentSpec spec) fn acc (World world) =
    Dict.foldr
        fn
        acc
        (spec.get world.components)


foldEntityComponentsFromFront2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> (comparable -> a1 -> a2 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromFront2 (ComponentSpec spec1) (ComponentSpec spec2) fn acc (World world) =
    Dict.Intersect.foldl2
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)


foldEntityComponentsFromBack2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> (comparable -> a1 -> a2 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromBack2 (ComponentSpec spec1) (ComponentSpec spec2) fn acc (World world) =
    Dict.Intersect.foldr2
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)


foldEntityComponentsFromFront3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> (comparable -> a1 -> a2 -> a3 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromFront3 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn acc (World world) =
    Dict.Intersect.foldl3
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)


foldEntityComponentsFromBack3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> (comparable -> a1 -> a2 -> a3 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromBack3 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn acc (World world) =
    Dict.Intersect.foldr3
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)


foldEntityComponentsFromFront4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromFront4 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) fn acc (World world) =
    Dict.Intersect.foldl4
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)


foldEntityComponentsFromBack4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromBack4 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) fn acc (World world) =
    Dict.Intersect.foldr4
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)


foldEntityComponentsFromFront5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromFront5 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) fn acc (World world) =
    Dict.Intersect.foldl5
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)


foldEntityComponentsFromBack5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromBack5 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) fn acc (World world) =
    Dict.Intersect.foldr5
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)


foldEntityComponentsFromFront6 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromFront6 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) fn acc (World world) =
    Dict.Intersect.foldl6
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)


foldEntityComponentsFromBack6 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromBack6 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) fn acc (World world) =
    Dict.Intersect.foldr6
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)


foldEntityComponentsFromFront7 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    -> ComponentSpec comparable a7 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromFront7 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) fn acc (World world) =
    Dict.Intersect.foldl7
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)
        (spec7.get world.components)


foldEntityComponentsFromBack7 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    -> ComponentSpec comparable a7 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromBack7 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) fn acc (World world) =
    Dict.Intersect.foldr7
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)
        (spec7.get world.components)


foldEntityComponentsFromFront8 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    -> ComponentSpec comparable a7 components
    -> ComponentSpec comparable a8 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromFront8 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) (ComponentSpec spec8) fn acc (World world) =
    Dict.Intersect.foldl8
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)
        (spec7.get world.components)
        (spec8.get world.components)


foldEntityComponentsFromBack8 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    -> ComponentSpec comparable a7 components
    -> ComponentSpec comparable a8 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldEntityComponentsFromBack8 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) (ComponentSpec spec8) fn acc (World world) =
    Dict.Intersect.foldr8
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)
        (spec7.get world.components)
        (spec8.get world.components)



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

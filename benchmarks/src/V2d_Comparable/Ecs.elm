module V2d_Comparable.Ecs exposing
    ( World, emptyWorld, isEmptyWorld, worldEntityIds
    , worldEntityCount, worldComponentCount
    , insertEntity, lastEntityId, hasEntity, clearEntity, removeEntity
    , hasComponent, getComponent, insertComponent, updateComponent, removeComponent
    , componentCount
    , getSingleton, setSingleton, updateSingleton
    , foldComponents2FromBack, foldComponents3FromBack, foldComponentsFromBack
    )

{-|


# World

@docs World, emptyWorld, isEmptyWorld, worldEntityIds
@docs worldEntityCount, worldComponentCount


# Entity

@docs insertEntity, lastEntityId, hasEntity, clearEntity, removeEntity


# Component

@docs hasComponent, getComponent, insertComponent, updateComponent, removeComponent
@docs componentCount


# Singletons

@docs getSingleton, setSingleton, updateSingleton

-}

import Dict
import Dict.Intersect
import Set exposing (Set)
import V2d_Comparable.Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , MultiComponentSpec(..)
        , SingletonSpec(..)
        )



-- WORLD --


type World comparable components singletons
    = World
        { entities :
            { lastId : Maybe comparable
            , activeIds : Set comparable
            }
        , components : components
        , singletons : singletons
        }


{-| Create an empty world without entities or components.
-}
emptyWorld : MultiComponentSpec comparable components -> singletons -> World comparable components singletons
emptyWorld (MultiComponentSpec componentsSpec) singletons =
    World
        { singletons = singletons
        , entities =
            { lastId = Nothing
            , activeIds = Set.empty
            }
        , components = componentsSpec.empty
        }


{-| Determine if the world is empty, without entities or components.
-}
isEmptyWorld : World comparable components singletons -> Bool
isEmptyWorld (World world) =
    Set.isEmpty world.entities.activeIds


{-| Determine the total number of entities in the world.
-}
worldEntityCount : World comparable components singletons -> Int
worldEntityCount (World world) =
    Set.size world.entities.activeIds


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
    Set.toList world.entities.activeIds



-- ENTITY --


insertEntity :
    comparable
    -> World comparable components singletons
    -> World comparable components singletons
insertEntity entityId (World { entities, components, singletons }) =
    World
        { entities =
            { lastId = Just entityId
            , activeIds = Set.insert entityId entities.activeIds
            }
        , components = components
        , singletons = singletons
        }


lastEntityId : World comparable components singletons -> Maybe comparable
lastEntityId (World { entities }) =
    entities.lastId


removeEntity :
    MultiComponentSpec comparable components
    -> comparable
    -> World comparable components singletons
    -> World comparable components singletons
removeEntity (MultiComponentSpec spec) entityId (World { entities, components, singletons }) =
    World
        { entities =
            { lastId = entities.lastId
            , activeIds = Set.remove entityId entities.activeIds
            }
        , components = spec.clear entityId components
        , singletons = singletons
        }


{-| Determine if an entity is in the world.
-}
hasEntity : comparable -> World comparable components singletons -> Bool
hasEntity entityId (World { entities }) =
    Set.member entityId entities.activeIds


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
    ComponentSpec comparable a components
    -> comparable
    -> (Maybe a -> Maybe a)
    -> World comparable components singletons
    -> World comparable components singletons
updateComponent (ComponentSpec spec) entityId fn (World world) =
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
componentCount : ComponentSpec comparable a components -> World comparable components singletons -> Int
componentCount (ComponentSpec spec) (World { components }) =
    Dict.size (spec.get components)



-- SINGLETON COMPONENTS --


getSingleton : SingletonSpec a singletons -> World comparable components singletons -> a
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



---


foldComponentsFromBack :
    ComponentSpec comparable a components
    -> (comparable -> a -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldComponentsFromBack (ComponentSpec spec) fn acc (World world) =
    Dict.foldr
        fn
        acc
        (spec.get world.components)


foldComponents2FromBack :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> (comparable -> a1 -> a2 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldComponents2FromBack (ComponentSpec spec1) (ComponentSpec spec2) fn acc (World world) =
    Dict.Intersect.foldr2
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)


foldComponents3FromBack :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> (comparable -> a1 -> a2 -> a3 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldComponents3FromBack (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn acc (World world) =
    Dict.Intersect.foldr3
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)

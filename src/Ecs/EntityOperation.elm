module Ecs.EntityOperation exposing
    ( EntityOperation, start
    , foldl, foldr
    , foldl2, foldr2
    , foldl3, foldr3
    , foldl3X
    )

{-|

@docs EntityOperation, start, end
@docs foldl, foldr
@docs foldl2, foldr2
@docs foldl3, foldr3
@docs foldl4, foldr4
@docs foldl5, foldr5
@docs foldl6, foldr6
@docs foldl7, foldr7
@docs foldl8, foldr8

-}

import Dict exposing (Dict)
import Dict.Intersect
import Ecs exposing (World)
import Ecs.EntityComponents
import Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , EntityOperation(..)
        , InternalWorld
        , World(..)
        )
import Set


{-| -}
type alias EntityOperation comparable components singletons =
    Internal.EntityOperation comparable components singletons


start :
    comparable
    -> World comparable components singletons
    -> Maybe (EntityOperation comparable components singletons)
start entityId (World world) =
    if Set.member entityId world.entities then
        Just (EntityOperation entityId world)

    else
        Nothing


insertComponent :
    ComponentSpec comparable a components
    -> a
    -> EntityOperation comparable components singletons
    -> EntityOperation comparable components singletons
insertComponent (ComponentSpec spec) a (EntityOperation entityId world) =
    EntityOperation
        entityId
        { entities = world.entities
        , components =
            spec.set
                (Dict.insert entityId a (spec.get world.components))
                world.components
        , singletons = world.singletons
        }


{-| -}
foldl :
    ComponentSpec comparable a components
    ->
        (a
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
foldl =
    fold Dict.foldl


{-| -}
foldr :
    ComponentSpec comparable a components
    ->
        (a
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
foldr =
    fold Dict.foldr


fold :
    ((comparable
      -> a
      -> InternalWorld comparable components singletons
      -> InternalWorld comparable components singletons
     )
     -> InternalWorld comparable components singletons
     -> Dict comparable a
     -> InternalWorld comparable components singletons
    )
    -> ComponentSpec comparable a components
    ->
        (a
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
fold foldFn (ComponentSpec spec) fn (World world) =
    World
        (foldFn
            (\entityId a world1 ->
                let
                    (EntityOperation _ world2) =
                        fn a (EntityOperation entityId world1)
                in
                world2
            )
            world
            (spec.get world.components)
        )


{-| -}
foldl2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    ->
        (a1
         -> a2
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
foldl2 =
    fold2 Dict.Intersect.foldl2


{-| -}
foldr2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    ->
        (a1
         -> a2
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
foldr2 =
    fold2 Dict.Intersect.foldr2


fold2 :
    ((comparable
      -> a1
      -> a2
      -> InternalWorld comparable components singletons
      -> InternalWorld comparable components singletons
     )
     -> InternalWorld comparable components singletons
     -> Dict comparable a1
     -> Dict comparable a2
     -> InternalWorld comparable components singletons
    )
    -> ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    ->
        (a1
         -> a2
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
fold2 foldFn (ComponentSpec spec1) (ComponentSpec spec2) fn (World world) =
    World
        (foldFn
            (\entityId a1 a2 world1 ->
                let
                    (EntityOperation _ world2) =
                        fn a1 a2 (EntityOperation entityId world1)
                in
                world2
            )
            world
            (spec1.get world.components)
            (spec2.get world.components)
        )


{-| -}
foldl3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    ->
        (a1
         -> a2
         -> a3
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
foldl3 =
    fold3 Dict.Intersect.foldl3


{-| -}
foldr3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    ->
        (a1
         -> a2
         -> a3
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
foldr3 =
    fold3 Dict.Intersect.foldr3


fold3 :
    ((comparable
      -> a1
      -> a2
      -> a3
      -> InternalWorld comparable components singletons
      -> InternalWorld comparable components singletons
     )
     -> InternalWorld comparable components singletons
     -> Dict comparable a1
     -> Dict comparable a2
     -> Dict comparable a3
     -> InternalWorld comparable components singletons
    )
    -> ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    ->
        (a1
         -> a2
         -> a3
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
fold3 foldFn (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn (World world) =
    World
        (foldFn
            (\entityId a1 a2 a3 world1 ->
                let
                    (EntityOperation _ world2) =
                        fn a1 a2 a3 (EntityOperation entityId world1)
                in
                world2
            )
            world
            (spec1.get world.components)
            (spec2.get world.components)
            (spec3.get world.components)
        )


{-| -}
foldl3X :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    ->
        (a1
         -> a2
         -> a3
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
foldl3X spec1 spec2 spec3 fn (World world) =
    World
        (Ecs.EntityComponents.foldl3
            spec1
            spec2
            spec3
            (\entityId a1 a2 a3 world1 ->
                let
                    (EntityOperation _ world2) =
                        fn a1 a2 a3 (EntityOperation entityId world1)
                in
                world2
            )
            world
            (World world)
        )

module Ecs.EntityComponents exposing
    ( foldFromFront, foldFromBack
    , foldFromFront2, foldFromBack2
    , foldFromFront3, foldFromBack3
    , foldFromFront4, foldFromBack4
    , foldFromFront5, foldFromBack5
    , foldFromFront6, foldFromBack6
    , foldFromFront7, foldFromBack7
    , foldFromFront8, foldFromBack8
    )

{-|

@docs foldFromFront, foldFromBack
@docs foldFromFront2, foldFromBack2
@docs foldFromFront3, foldFromBack3
@docs foldFromFront4, foldFromBack4
@docs foldFromFront5, foldFromBack5
@docs foldFromFront6, foldFromBack6
@docs foldFromFront7, foldFromBack7
@docs foldFromFront8, foldFromBack8

-}

import Dict
import Dict.Intersect
import Ecs exposing (World)
import Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , World(..)
        )


foldFromFront :
    ComponentSpec comparable a components
    -> (comparable -> a -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromFront (ComponentSpec spec) fn acc (World world) =
    Dict.foldl
        fn
        acc
        (spec.get world.components)


foldFromBack :
    ComponentSpec comparable a components
    -> (comparable -> a -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromBack (ComponentSpec spec) fn acc (World world) =
    Dict.foldr
        fn
        acc
        (spec.get world.components)


foldFromFront2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> (comparable -> a1 -> a2 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromFront2 (ComponentSpec spec1) (ComponentSpec spec2) fn acc (World world) =
    Dict.Intersect.foldl2
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)


foldFromBack2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> (comparable -> a1 -> a2 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromBack2 (ComponentSpec spec1) (ComponentSpec spec2) fn acc (World world) =
    Dict.Intersect.foldr2
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)


foldFromFront3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> (comparable -> a1 -> a2 -> a3 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromFront3 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn acc (World world) =
    Dict.Intersect.foldl3
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)


foldFromBack3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> (comparable -> a1 -> a2 -> a3 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromBack3 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn acc (World world) =
    Dict.Intersect.foldr3
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)


foldFromFront4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromFront4 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) fn acc (World world) =
    Dict.Intersect.foldl4
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)


foldFromBack4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromBack4 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) fn acc (World world) =
    Dict.Intersect.foldr4
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)


foldFromFront5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromFront5 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) fn acc (World world) =
    Dict.Intersect.foldl5
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)


foldFromBack5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromBack5 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) fn acc (World world) =
    Dict.Intersect.foldr5
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)


foldFromFront6 :
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
foldFromFront6 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) fn acc (World world) =
    Dict.Intersect.foldl6
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)


foldFromBack6 :
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
foldFromBack6 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) fn acc (World world) =
    Dict.Intersect.foldr6
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)


foldFromFront7 :
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
foldFromFront7 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) fn acc (World world) =
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


foldFromBack7 :
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
foldFromBack7 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) fn acc (World world) =
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


foldFromFront8 :
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
foldFromFront8 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) (ComponentSpec spec8) fn acc (World world) =
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


foldFromBack8 :
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
foldFromBack8 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) (ComponentSpec spec8) fn acc (World world) =
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

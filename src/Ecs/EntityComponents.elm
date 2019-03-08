module Ecs.EntityComponents exposing
    ( foldl, foldr
    , foldl2, foldr2
    , foldl3, foldr3
    , foldl4, foldr4
    , foldl5, foldr5
    , foldl6, foldr6
    , foldl7, foldr7
    , foldl8, foldr8
    )

{-|

@docs foldl, foldr
@docs foldl2, foldr2
@docs foldl3, foldr3
@docs foldl4, foldr4
@docs foldl5, foldr5
@docs foldl6, foldr6
@docs foldl7, foldr7
@docs foldl8, foldr8

-}

import Dict
import Dict.Intersect
import Ecs exposing (World)
import Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , World(..)
        )


{-| -}
foldl :
    ComponentSpec comparable a components
    -> (comparable -> a -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldl (ComponentSpec spec) fn acc (World world) =
    Dict.foldl
        fn
        acc
        (spec.get world.components)


{-| -}
foldr :
    ComponentSpec comparable a components
    -> (comparable -> a -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldr (ComponentSpec spec) fn acc (World world) =
    Dict.foldr
        fn
        acc
        (spec.get world.components)


{-| -}
foldl2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> (comparable -> a1 -> a2 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldl2 (ComponentSpec spec1) (ComponentSpec spec2) fn acc (World world) =
    Dict.Intersect.foldl2
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)


{-| -}
foldr2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> (comparable -> a1 -> a2 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldr2 (ComponentSpec spec1) (ComponentSpec spec2) fn acc (World world) =
    Dict.Intersect.foldr2
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)


{-| -}
foldl3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> (comparable -> a1 -> a2 -> a3 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldl3 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn acc (World world) =
    Dict.Intersect.foldl3
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)


{-| -}
foldr3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> (comparable -> a1 -> a2 -> a3 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldr3 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn acc (World world) =
    Dict.Intersect.foldr3
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)


{-| -}
foldl4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldl4 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) fn acc (World world) =
    Dict.Intersect.foldl4
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)


{-| -}
foldr4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldr4 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) fn acc (World world) =
    Dict.Intersect.foldr4
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)


{-| -}
foldl5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldl5 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) fn acc (World world) =
    Dict.Intersect.foldl5
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)


{-| -}
foldr5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldr5 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) fn acc (World world) =
    Dict.Intersect.foldr5
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)


{-| -}
foldl6 :
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
foldl6 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) fn acc (World world) =
    Dict.Intersect.foldl6
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)


{-| -}
foldr6 :
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
foldr6 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) fn acc (World world) =
    Dict.Intersect.foldr6
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)


{-| -}
foldl7 :
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
foldl7 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) fn acc (World world) =
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


{-| -}
foldr7 :
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
foldr7 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) fn acc (World world) =
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


{-| -}
foldl8 :
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
foldl8 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) (ComponentSpec spec8) fn acc (World world) =
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


{-| -}
foldr8 :
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
foldr8 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) (ComponentSpec spec8) fn acc (World world) =
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

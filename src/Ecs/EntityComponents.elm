module Ecs.EntityComponents exposing
    ( processFromLeft, processFromRight
    , processFromLeft2, processFromRight2
    , processFromLeft3, processFromRight3
    , processFromLeft4, processFromRight4
    , processFromLeft5, processFromRight5
    , processFromLeft6, processFromRight6
    , processFromLeft7, processFromRight7
    , processFromLeft8, processFromRight8
    , foldFromLeft, foldFromRight
    , foldFromLeft2, foldFromRight2
    , foldFromLeft3, foldFromRight3
    , foldFromLeft4, foldFromRight4
    , foldFromLeft5, foldFromRight5
    , foldFromLeft6, foldFromRight6
    , foldFromLeft7, foldFromRight7
    , foldFromLeft8, foldFromRight8
    )

{-|


# Process

@docs processFromLeft, processFromRight
@docs processFromLeft2, processFromRight2
@docs processFromLeft3, processFromRight3
@docs processFromLeft4, processFromRight4
@docs processFromLeft5, processFromRight5
@docs processFromLeft6, processFromRight6
@docs processFromLeft7, processFromRight7
@docs processFromLeft8, processFromRight8


# Fold

@docs foldFromLeft, foldFromRight
@docs foldFromLeft2, foldFromRight2
@docs foldFromLeft3, foldFromRight3
@docs foldFromLeft4, foldFromRight4
@docs foldFromLeft5, foldFromRight5
@docs foldFromLeft6, foldFromRight6
@docs foldFromLeft7, foldFromRight7
@docs foldFromLeft8, foldFromRight8

-}

import Dict
import Dict.Intersect
import Ecs exposing (World)
import Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , World(..)
        )



-- PROCESS --


{-| -}
processFromLeft :
    ComponentSpec comparable a components
    ->
        (comparable
         -> a
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromLeft (ComponentSpec spec) fn (World world) =
    Dict.foldl
        (entityFn fn)
        (World world)
        (spec.get world.components)


{-| -}
processFromRight :
    ComponentSpec comparable a components
    ->
        (comparable
         -> a
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromRight (ComponentSpec spec) fn (World world) =
    Dict.foldr
        (entityFn fn)
        (World world)
        (spec.get world.components)


entityFn :
    (comparable
     -> a
     -> World comparable components singletons
     -> World comparable components singletons
    )
    -> comparable
    -> a
    -> World comparable components singletons
    -> World comparable components singletons
entityFn fn entityId a (World world) =
    fn
        entityId
        a
        (World
            { entities = world.entities
            , activeEntity = Just entityId
            , components = world.components
            , singletons = world.singletons
            }
        )


{-| -}
processFromLeft2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    ->
        (comparable
         -> a1
         -> a2
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromLeft2 (ComponentSpec spec1) (ComponentSpec spec2) fn (World world) =
    Dict.Intersect.foldl2
        (entityFn2 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)


{-| -}
processFromRight2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    ->
        (comparable
         -> a1
         -> a2
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromRight2 (ComponentSpec spec1) (ComponentSpec spec2) fn (World world) =
    Dict.Intersect.foldr2
        (entityFn2 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)


entityFn2 :
    (comparable
     -> a1
     -> a2
     -> World comparable components singletons
     -> World comparable components singletons
    )
    -> comparable
    -> a1
    -> a2
    -> World comparable components singletons
    -> World comparable components singletons
entityFn2 fn entityId a1 a2 (World world) =
    fn
        entityId
        a1
        a2
        (World
            { entities = world.entities
            , activeEntity = Just entityId
            , components = world.components
            , singletons = world.singletons
            }
        )


{-| -}
processFromLeft3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromLeft3 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn (World world) =
    Dict.Intersect.foldl3
        (entityFn3 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)


{-| -}
processFromRight3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromRight3 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn (World world) =
    Dict.Intersect.foldr3
        (entityFn3 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)


entityFn3 :
    (comparable
     -> a1
     -> a2
     -> a3
     -> World comparable components singletons
     -> World comparable components singletons
    )
    -> comparable
    -> a1
    -> a2
    -> a3
    -> World comparable components singletons
    -> World comparable components singletons
entityFn3 fn entityId a1 a2 a3 (World world) =
    fn
        entityId
        a1
        a2
        a3
        (World
            { entities = world.entities
            , activeEntity = Just entityId
            , components = world.components
            , singletons = world.singletons
            }
        )


{-| -}
processFromLeft4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> a4
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromLeft4 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) fn (World world) =
    Dict.Intersect.foldl4
        (entityFn4 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)


{-| -}
processFromRight4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> a4
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromRight4 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) fn (World world) =
    Dict.Intersect.foldr4
        (entityFn4 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)


entityFn4 :
    (comparable
     -> a1
     -> a2
     -> a3
     -> a4
     -> World comparable components singletons
     -> World comparable components singletons
    )
    -> comparable
    -> a1
    -> a2
    -> a3
    -> a4
    -> World comparable components singletons
    -> World comparable components singletons
entityFn4 fn entityId a1 a2 a3 a4 (World world) =
    fn
        entityId
        a1
        a2
        a3
        a4
        (World
            { entities = world.entities
            , activeEntity = Just entityId
            , components = world.components
            , singletons = world.singletons
            }
        )


{-| -}
processFromLeft5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> a4
         -> a5
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromLeft5 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) fn (World world) =
    Dict.Intersect.foldl5
        (entityFn5 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)


{-| -}
processFromRight5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> a4
         -> a5
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromRight5 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) fn (World world) =
    Dict.Intersect.foldr5
        (entityFn5 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)


entityFn5 :
    (comparable
     -> a1
     -> a2
     -> a3
     -> a4
     -> a5
     -> World comparable components singletons
     -> World comparable components singletons
    )
    -> comparable
    -> a1
    -> a2
    -> a3
    -> a4
    -> a5
    -> World comparable components singletons
    -> World comparable components singletons
entityFn5 fn entityId a1 a2 a3 a4 a5 (World world) =
    fn
        entityId
        a1
        a2
        a3
        a4
        a5
        (World
            { entities = world.entities
            , activeEntity = Just entityId
            , components = world.components
            , singletons = world.singletons
            }
        )


{-| -}
processFromLeft6 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> a4
         -> a5
         -> a6
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromLeft6 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) fn (World world) =
    Dict.Intersect.foldl6
        (entityFn6 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)


{-| -}
processFromRight6 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> a4
         -> a5
         -> a6
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromRight6 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) fn (World world) =
    Dict.Intersect.foldr6
        (entityFn6 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)


entityFn6 :
    (comparable
     -> a1
     -> a2
     -> a3
     -> a4
     -> a5
     -> a6
     -> World comparable components singletons
     -> World comparable components singletons
    )
    -> comparable
    -> a1
    -> a2
    -> a3
    -> a4
    -> a5
    -> a6
    -> World comparable components singletons
    -> World comparable components singletons
entityFn6 fn entityId a1 a2 a3 a4 a5 a6 (World world) =
    fn
        entityId
        a1
        a2
        a3
        a4
        a5
        a6
        (World
            { entities = world.entities
            , activeEntity = Just entityId
            , components = world.components
            , singletons = world.singletons
            }
        )


{-| -}
processFromLeft7 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    -> ComponentSpec comparable a7 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> a4
         -> a5
         -> a6
         -> a7
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromLeft7 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) fn (World world) =
    Dict.Intersect.foldl7
        (entityFn7 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)
        (spec7.get world.components)


{-| -}
processFromRight7 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    -> ComponentSpec comparable a7 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> a4
         -> a5
         -> a6
         -> a7
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromRight7 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) fn (World world) =
    Dict.Intersect.foldr7
        (entityFn7 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)
        (spec7.get world.components)


entityFn7 :
    (comparable
     -> a1
     -> a2
     -> a3
     -> a4
     -> a5
     -> a6
     -> a7
     -> World comparable components singletons
     -> World comparable components singletons
    )
    -> comparable
    -> a1
    -> a2
    -> a3
    -> a4
    -> a5
    -> a6
    -> a7
    -> World comparable components singletons
    -> World comparable components singletons
entityFn7 fn entityId a1 a2 a3 a4 a5 a6 a7 (World world) =
    fn
        entityId
        a1
        a2
        a3
        a4
        a5
        a6
        a7
        (World
            { entities = world.entities
            , activeEntity = Just entityId
            , components = world.components
            , singletons = world.singletons
            }
        )


{-| -}
processFromLeft8 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    -> ComponentSpec comparable a7 components
    -> ComponentSpec comparable a8 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> a4
         -> a5
         -> a6
         -> a7
         -> a8
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromLeft8 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) (ComponentSpec spec8) fn (World world) =
    Dict.Intersect.foldl8
        (entityFn8 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)
        (spec7.get world.components)
        (spec8.get world.components)


{-| -}
processFromRight8 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> ComponentSpec comparable a6 components
    -> ComponentSpec comparable a7 components
    -> ComponentSpec comparable a8 components
    ->
        (comparable
         -> a1
         -> a2
         -> a3
         -> a4
         -> a5
         -> a6
         -> a7
         -> a8
         -> World comparable components singletons
         -> World comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
processFromRight8 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) (ComponentSpec spec8) fn (World world) =
    Dict.Intersect.foldr8
        (entityFn8 fn)
        (World world)
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)
        (spec6.get world.components)
        (spec7.get world.components)
        (spec8.get world.components)


entityFn8 :
    (comparable
     -> a1
     -> a2
     -> a3
     -> a4
     -> a5
     -> a6
     -> a7
     -> a8
     -> World comparable components singletons
     -> World comparable components singletons
    )
    -> comparable
    -> a1
    -> a2
    -> a3
    -> a4
    -> a5
    -> a6
    -> a7
    -> a8
    -> World comparable components singletons
    -> World comparable components singletons
entityFn8 fn entityId a1 a2 a3 a4 a5 a6 a7 a8 (World world) =
    fn
        entityId
        a1
        a2
        a3
        a4
        a5
        a6
        a7
        a8
        (World
            { entities = world.entities
            , activeEntity = Just entityId
            , components = world.components
            , singletons = world.singletons
            }
        )



-- FOLD --


{-| -}
foldFromLeft :
    ComponentSpec comparable a components
    -> (comparable -> a -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromLeft (ComponentSpec spec) fn acc (World world) =
    Dict.foldl
        fn
        acc
        (spec.get world.components)


{-| -}
foldFromRight :
    ComponentSpec comparable a components
    -> (comparable -> a -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromRight (ComponentSpec spec) fn acc (World world) =
    Dict.foldr
        fn
        acc
        (spec.get world.components)


{-| -}
foldFromLeft2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> (comparable -> a1 -> a2 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromLeft2 (ComponentSpec spec1) (ComponentSpec spec2) fn acc (World world) =
    Dict.Intersect.foldl2
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)


{-| -}
foldFromRight2 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> (comparable -> a1 -> a2 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromRight2 (ComponentSpec spec1) (ComponentSpec spec2) fn acc (World world) =
    Dict.Intersect.foldr2
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)


{-| -}
foldFromLeft3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> (comparable -> a1 -> a2 -> a3 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromLeft3 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn acc (World world) =
    Dict.Intersect.foldl3
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)


{-| -}
foldFromRight3 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> (comparable -> a1 -> a2 -> a3 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromRight3 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) fn acc (World world) =
    Dict.Intersect.foldr3
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)


{-| -}
foldFromLeft4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromLeft4 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) fn acc (World world) =
    Dict.Intersect.foldl4
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)


{-| -}
foldFromRight4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromRight4 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) fn acc (World world) =
    Dict.Intersect.foldr4
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)


{-| -}
foldFromLeft5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromLeft5 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) fn acc (World world) =
    Dict.Intersect.foldl5
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)


{-| -}
foldFromRight5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    -> (comparable -> a1 -> a2 -> a3 -> a4 -> a5 -> acc -> acc)
    -> acc
    -> World comparable components singletons
    -> acc
foldFromRight5 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) fn acc (World world) =
    Dict.Intersect.foldr5
        fn
        acc
        (spec1.get world.components)
        (spec2.get world.components)
        (spec3.get world.components)
        (spec4.get world.components)
        (spec5.get world.components)


{-| -}
foldFromLeft6 :
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
foldFromLeft6 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) fn acc (World world) =
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
foldFromRight6 :
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
foldFromRight6 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) fn acc (World world) =
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
foldFromLeft7 :
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
foldFromLeft7 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) fn acc (World world) =
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
foldFromRight7 :
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
foldFromRight7 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) fn acc (World world) =
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
foldFromLeft8 :
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
foldFromLeft8 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) (ComponentSpec spec8) fn acc (World world) =
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
foldFromRight8 :
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
foldFromRight8 (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) (ComponentSpec spec6) (ComponentSpec spec7) (ComponentSpec spec8) fn acc (World world) =
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

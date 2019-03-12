module V2e_EntityOperation.Ecs.EntityOperation exposing
    ( EntityOperation, start, end
    , insertComponent, updateComponent, removeComponent
    , hasComponent, getComponent
    , foldl, foldr
    , foldl2, foldr2
    , foldl3, foldr3
    , foldl4, foldr4
    , foldl5, foldr5
    )

{-|

@docs EntityOperation, start, end
@docs insertComponent, updateComponent, removeComponent
@docs hasComponent, getComponent
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
import Set
import V2e_EntityOperation.Ecs exposing (World)
import V2e_EntityOperation.Ecs.EntityComponents as EntityComponents
import V2e_EntityOperation.Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , EntityOperation(..)
        , InternalWorld
        , World(..)
        )


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


end :
    EntityOperation comparable components singletons
    -> World comparable components singletons
end (EntityOperation _ world) =
    World world


{-| Determines if an entity has a specific component.
-}
hasComponent :
    ComponentSpec comparable a components
    -> EntityOperation comparable components singletons
    -> Bool
hasComponent (ComponentSpec spec) (EntityOperation entityId { components }) =
    Dict.member entityId (spec.get components)


{-| Get a specific component of an entity.
-}
getComponent :
    ComponentSpec comparable a components
    -> EntityOperation comparable components singletons
    -> Maybe a
getComponent (ComponentSpec spec) (EntityOperation entityId { components }) =
    Dict.get entityId (spec.get components)


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


updateComponent :
    ComponentSpec comparable a components
    -> (Maybe a -> Maybe a)
    -> EntityOperation comparable components singletons
    -> EntityOperation comparable components singletons
updateComponent (ComponentSpec spec) fn (EntityOperation entityId world) =
    EntityOperation
        entityId
        { entities = world.entities
        , components =
            spec.set
                (Dict.update entityId fn (spec.get world.components))
                world.components
        , singletons = world.singletons
        }


removeComponent :
    ComponentSpec comparable a components
    -> EntityOperation comparable components singletons
    -> EntityOperation comparable components singletons
removeComponent (ComponentSpec spec) (EntityOperation entityId world) =
    EntityOperation
        entityId
        { entities = world.entities
        , components =
            spec.set
                (Dict.remove entityId (spec.get world.components))
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
foldl4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    ->
        (a1
         -> a2
         -> a3
         -> a4
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
foldl4 =
    fold4 Dict.Intersect.foldl4


{-| -}
foldr4 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    ->
        (a1
         -> a2
         -> a3
         -> a4
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
foldr4 =
    fold4 Dict.Intersect.foldr4


fold4 :
    ((comparable
      -> a1
      -> a2
      -> a3
      -> a4
      -> InternalWorld comparable components singletons
      -> InternalWorld comparable components singletons
     )
     -> InternalWorld comparable components singletons
     -> Dict comparable a1
     -> Dict comparable a2
     -> Dict comparable a3
     -> Dict comparable a4
     -> InternalWorld comparable components singletons
    )
    -> ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    ->
        (a1
         -> a2
         -> a3
         -> a4
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
fold4 foldFn (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) fn (World world) =
    World
        (foldFn
            (\entityId a1 a2 a3 a4 world1 ->
                let
                    (EntityOperation _ world2) =
                        fn a1 a2 a3 a4 (EntityOperation entityId world1)
                in
                world2
            )
            world
            (spec1.get world.components)
            (spec2.get world.components)
            (spec3.get world.components)
            (spec4.get world.components)
        )


{-| -}
foldl5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    ->
        (a1
         -> a2
         -> a3
         -> a4
         -> a5
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
foldl5 =
    fold5 Dict.Intersect.foldl5


{-| -}
foldr5 :
    ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    ->
        (a1
         -> a2
         -> a3
         -> a4
         -> a5
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
foldr5 =
    fold5 Dict.Intersect.foldr5


fold5 :
    ((comparable
      -> a1
      -> a2
      -> a3
      -> a4
      -> a5
      -> InternalWorld comparable components singletons
      -> InternalWorld comparable components singletons
     )
     -> InternalWorld comparable components singletons
     -> Dict comparable a1
     -> Dict comparable a2
     -> Dict comparable a3
     -> Dict comparable a4
     -> Dict comparable a5
     -> InternalWorld comparable components singletons
    )
    -> ComponentSpec comparable a1 components
    -> ComponentSpec comparable a2 components
    -> ComponentSpec comparable a3 components
    -> ComponentSpec comparable a4 components
    -> ComponentSpec comparable a5 components
    ->
        (a1
         -> a2
         -> a3
         -> a4
         -> a5
         -> EntityOperation comparable components singletons
         -> EntityOperation comparable components singletons
        )
    -> World comparable components singletons
    -> World comparable components singletons
fold5 foldFn (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) (ComponentSpec spec4) (ComponentSpec spec5) fn (World world) =
    World
        (foldFn
            (\entityId a1 a2 a3 a4 a5 world1 ->
                let
                    (EntityOperation _ world2) =
                        fn a1 a2 a3 a4 a5 (EntityOperation entityId world1)
                in
                world2
            )
            world
            (spec1.get world.components)
            (spec2.get world.components)
            (spec3.get world.components)
            (spec4.get world.components)
            (spec5.get world.components)
        )

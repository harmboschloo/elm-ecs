module Ecs.Internal exposing
    ( AllComponentSpec(..)
    , ComponentSpec(..)
    , EntityOperation(..)
    , InternalWorld
    , SingletonSpec(..)
    , World(..)
    )

import Dict exposing (Dict)
import Set exposing (Set)


type AllComponentSpec comparable components
    = AllComponentSpec
        { empty : components
        , clear : comparable -> components -> components
        , size : components -> Int
        }


type ComponentSpec comparable a components
    = ComponentSpec
        { get : components -> Dict comparable a
        , set : Dict comparable a -> components -> components
        }


type SingletonSpec a singletons
    = SingletonSpec
        { get : singletons -> a
        , set : a -> singletons -> singletons
        }


type World comparable components singletons
    = World (InternalWorld comparable components singletons)


type alias InternalWorld comparable components singletons =
    { entities : Set comparable
    , components : components
    , singletons : singletons
    }


type EntityOperation comparable components singletons
    = EntityOperation comparable (InternalWorld comparable components singletons)

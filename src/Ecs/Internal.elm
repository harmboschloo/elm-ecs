module Ecs.Internal exposing
    ( AllComponentsSpec(..)
    , ComponentSpec(..)
    , InternalWorld
    , SingletonSpec(..)
    , World(..)
    )

import Dict exposing (Dict)
import Set exposing (Set)


type AllComponentsSpec comparable components
    = AllComponentsSpec
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
    , activeEntity : Maybe comparable
    , components : components
    , singletons : singletons
    }

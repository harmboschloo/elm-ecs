module Ecs.Internal exposing
    ( ComponentSpec(..)
    , MultiComponentSpec(..)
    , SingletonSpec(..)
    )

import Dict exposing (Dict)


type MultiComponentSpec comparable components
    = MultiComponentSpec
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

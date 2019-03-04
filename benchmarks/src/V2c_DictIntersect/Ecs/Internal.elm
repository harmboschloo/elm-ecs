module V2c_DictIntersect.Ecs.Internal exposing
    ( AllComponentsSpec(..)
    , ComponentSpec(..)
    , EntityId(..)
    , SingletonSpec(..)
    )

import Dict exposing (Dict)


type EntityId
    = EntityId Int


type AllComponentsSpec components
    = AllComponentsSpec
        { empty : components
        , clear : Int -> components -> components
        , size : components -> Int
        }


type ComponentSpec components a
    = ComponentSpec
        { get : components -> Dict Int a
        , set : Dict Int a -> components -> components
        }


type SingletonSpec singletons a
    = SingletonSpec
        { get : singletons -> a
        , set : a -> singletons -> singletons
        }

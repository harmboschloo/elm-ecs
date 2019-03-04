module V2b_Singletons.Ecs.Internal exposing
    ( AllComponentsSpec(..)
    , ComponentSpec(..)
    , EntityId(..)
    , Selector(..)
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
        , update : (Dict Int a -> Dict Int a) -> components -> components
        }


type SingletonSpec singletons a
    = SingletonSpec
        { get : singletons -> a
        , update : (a -> a) -> singletons -> singletons
        }


type Selector components a
    = Selector
        { select : Int -> components -> Maybe a
        , selectAll : components -> List ( EntityId, a )
        }

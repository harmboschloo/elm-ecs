module Ecs.Internal exposing
    ( ComponentSpec(..)
    , EntityId(..)
    , Selector(..)
    , Spec(..)
    )

import Dict exposing (Dict)
import Set exposing (Set)


type EntityId
    = EntityId Int


type Spec components
    = Spec
        { empty : components
        , clear : Int -> components -> components
        , size : components -> Int
        }


type ComponentSpec components a
    = ComponentSpec
        { get : components -> Dict Int a
        , update : (Dict Int a -> Dict Int a) -> components -> components
        }


type Selector components a
    = Selector
        { select : Int -> components -> Maybe a
        , selectAll : components -> List ( EntityId, a )
        }

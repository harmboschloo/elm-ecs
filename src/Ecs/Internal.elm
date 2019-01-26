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


type Spec data
    = Spec
        { empty : data
        , clear : Int -> data -> data
        , size : data -> Int
        }


type ComponentSpec data a
    = ComponentSpec
        { get : data -> Dict Int a
        , update : (Dict Int a -> Dict Int a) -> data -> data
        }


type Selector data a
    = Selector
        { select : Int -> data -> Maybe a
        , selectList : data -> List ( EntityId, a )
        }

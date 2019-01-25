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


type Spec ecs
    = Spec
        { empty : ecs
        , clear : EntityId -> ecs -> ecs
        , isEmpty : ecs -> Bool
        , componentCount : ecs -> Int
        , ids : ecs -> Set Int
        , member : EntityId -> ecs -> Bool
        , create : ecs -> ( ecs, EntityId )
        , destroy : EntityId -> ecs -> ecs
        }


type ComponentSpec ecs a
    = ComponentSpec
        { get : ecs -> Dict Int a
        , update : (Dict Int a -> Dict Int a) -> ecs -> ecs
        }


type Selector ecs a
    = Selector
        { select : Int -> ecs -> Maybe a
        , selectList : ecs -> List ( EntityId, a )
        }

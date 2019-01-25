module V1.Ecs.Internal exposing (ComponentSpec(..), Selector(..), Spec(..))

import Dict exposing (Dict)
import Set exposing (Set)


type Spec comparable ecs
    = Spec
        { empty : ecs
        , clear : comparable -> ecs -> ecs
        , isEmpty : ecs -> Bool
        , componentCount : ecs -> Int
        , ids : ecs -> Set comparable
        , member : comparable -> ecs -> Bool
        }


type ComponentSpec comparable ecs a
    = ComponentSpec
        { get : ecs -> Dict comparable a
        , update : (Dict comparable a -> Dict comparable a) -> ecs -> ecs
        }


type Selector comparable ecs a
    = Selector
        { select : comparable -> ecs -> Maybe a
        , selectList : ecs -> List ( comparable, a )
        }

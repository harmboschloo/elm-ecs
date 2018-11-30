module Ecs.Internal exposing (ComponentSpec(..), EcsSpec(..), Selector(..))

import Dict exposing (Dict)
import Set exposing (Set)


type EcsSpec comparable model
    = EcsSpec
        { empty : model
        , clear : comparable -> model -> model
        , isEmpty : model -> Bool
        , componentCount : model -> Int
        , ids : model -> Set comparable
        , member : comparable -> model -> Bool
        }


type ComponentSpec comparable model data
    = ComponentSpec
        { get : model -> Dict comparable data
        , update : (Dict comparable data -> Dict comparable data) -> model -> model
        }


type Selector comparable model a
    = Selector
        { select : comparable -> model -> Maybe a
        , selectList : model -> List ( comparable, a )
        }

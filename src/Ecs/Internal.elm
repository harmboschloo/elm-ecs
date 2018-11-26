module Ecs.Internal exposing (ComponentType(..), EcsType(..), Selector(..))

import Dict exposing (Dict)
import Set exposing (Set)


type EcsType comparable model
    = EcsType
        { empty : model
        , clear : comparable -> model -> model
        , isEmpty : model -> Bool
        , componentCount : model -> Int
        , ids : model -> Set comparable
        , member : comparable -> model -> Bool
        }


type ComponentType comparable model data
    = ComponentType
        { get : model -> Dict comparable data
        , update : (Dict comparable data -> Dict comparable data) -> model -> model
        }


type Selector comparable model a
    = Selector
        { select : comparable -> model -> Maybe a
        , selectList : model -> List ( comparable, a )
        }

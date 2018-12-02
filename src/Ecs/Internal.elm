module Ecs.Internal exposing (ComponentSpec(..), Spec(..))

import Dict exposing (Dict)
import Set exposing (Set)


type Spec componentSpecs comparable model
    = Spec
        { empty : model
        , clear : comparable -> model -> model
        , isEmpty : model -> Bool
        , componentCount : model -> Int
        , ids : model -> Set comparable
        , member : comparable -> model -> Bool
        , components : componentSpecs
        }


type ComponentSpec comparable model data
    = ComponentSpec
        { get : model -> Dict comparable data
        , update : (Dict comparable data -> Dict comparable data) -> model -> model
        }

module Ecs.AR.Internal.Ecs exposing
    ( Ecs(..)
    , Model
    , ProcessState
    )

import Array exposing (Array)
import Ecs.AR.Internal.Entity exposing (Entity, EntityId, Id, Index)


type Ecs a
    = Ecs (Model a)


type alias Model a =
    { all : Array (Entity a)
    , nextId : Id
    , destroyed : List Index
    }


type alias ProcessState a b =
    { ecs : Ecs a
    , b : b
    , update : List ( EntityId, a -> a )
    }

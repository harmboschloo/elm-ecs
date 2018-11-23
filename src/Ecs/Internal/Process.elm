module Ecs.Internal.Process exposing
    ( Current
    , Process(..)
    , Status(..)
    )

import Ecs.Internal.Ecs exposing (Ecs)
import Ecs.Internal.Entity exposing (EntityId)


type Process a
    = Process
        { ecs : Ecs a
        , current : Current a
        , update : List ( EntityId, a -> a )
        }


type alias Current a =
    { id : EntityId
    , a : a
    , status : Status
    }


type Status
    = NotModified
    | Modified
    | Destroyed

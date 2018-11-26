module Ecs.AR.Internal.Entity exposing
    ( Entity(..)
    , EntityId(..)
    , Id
    , Index
    )


type Entity a
    = Exists Id a
    | Destroyed


type EntityId
    = EntityId Id Index


type alias Id =
    Int


type alias Index =
    Int

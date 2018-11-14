module Ecs8b.Internal exposing
    ( ComponentSpec(..)
    , Ecs(..)
    , Entity(..)
    , EntitySpec(..)
    , NodeSpec(..)
    , Status(..)
    )

import Array exposing (Array)


type Ecs components
    = Ecs (Model components)


type alias Model components =
    { entities : Array (Maybe components)
    , destroyedEntities : List Int
    }


type EntitySpec components
    = EntitySpec { empty : components }


type Entity components
    = Entity Int components Status


type Status
    = Unmodified
    | Modified


type EntityId
    = EntityId Int


type ComponentSpec components component
    = ComponentSpec
        { getComponent : components -> Maybe component
        , setComponent : Maybe component -> components -> components
        }


type NodeSpec components node
    = NodeSpec
        { getNode : components -> Maybe node
        , setNode : node -> components -> components
        }

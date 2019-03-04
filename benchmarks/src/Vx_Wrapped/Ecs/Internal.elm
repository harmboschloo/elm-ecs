module Vx_Wrapped.Ecs.Internal exposing
    ( ComponentEntry(..)
    , ComponentSpec(..)
    , ComponentSpecModel
    , Ecs(..)
    , EntityId(..)
    , Model
    , Operation(..)
    , Selector(..)
    )

import Array exposing (Array)
import Dict exposing (Dict)
import Set exposing (Set)


type ComponentSpec data a
    = ComponentSpec (ComponentSpecModel data a)


type alias ComponentSpecModel data a =
    { id : Int
    , wrap : a -> data
    , unwrap : data -> Maybe a
    }


type Ecs data
    = Ecs (Model data)


type alias Model data =
    { containers : Array (Dict Int data)
    , nextId : Int
    , activeIds : Set Int
    }


type EntityId
    = EntityId Int


type ComponentEntry data
    = ComponentEntry
        { id : Int
        , data : data
        }


type Operation data
    = Create (List (ComponentEntry data))
    | Destroy EntityId
    | InsertAll EntityId (List (ComponentEntry data))
    | Insert EntityId (ComponentEntry data)
    | Remove EntityId Int


type Selector data a
    = Selector
        { select : Int -> Model data -> Maybe a
        , selectList : Model data -> List ( EntityId, a )
        }

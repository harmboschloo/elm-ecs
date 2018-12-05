module Ecs exposing
    ( empty, isEmpty, entityCount, componentCount, ids
    , member, clear
    , has, get, insert, update, remove, size
    , select, selectList
    )

{-|

@docs empty, isEmpty, entityCount, componentCount, ids
@docs member, clear
@docs has, get, insert, update, remove, size
@docs select, selectList

-}

import Dict exposing (Dict)
import Ecs.Internal exposing (ComponentSpec(..), Selector(..), Spec(..))
import Set exposing (Set)



-- MODEL --


{-| -}
empty : Spec comparable ecs -> ecs
empty (Spec spec) =
    spec.empty


{-| -}
isEmpty : Spec comparable ecs -> ecs -> Bool
isEmpty (Spec spec) ecs =
    spec.isEmpty ecs


{-| -}
entityCount : Spec comparable ecs -> ecs -> Int
entityCount spec ecs =
    Set.size (ids spec ecs)


{-| -}
componentCount : Spec comparable ecs -> ecs -> Int
componentCount (Spec spec) ecs =
    spec.componentCount ecs


{-| -}
ids : Spec comparable ecs -> ecs -> Set comparable
ids (Spec spec) ecs =
    spec.ids ecs



-- ENTITY --


{-| -}
member : Spec comparable ecs -> comparable -> ecs -> Bool
member (Spec spec) id ecs =
    spec.member id ecs


{-| -}
clear : Spec comparable ecs -> comparable -> ecs -> ecs
clear (Spec spec) id ecs =
    spec.clear id ecs



-- COMPONENTS --


{-| -}
has : ComponentSpec comparable ecs a -> comparable -> ecs -> Bool
has (ComponentSpec spec) id ecs =
    Dict.member id (spec.get ecs)


{-| -}
get : ComponentSpec comparable ecs a -> comparable -> ecs -> Maybe a
get (ComponentSpec spec) id ecs =
    Dict.get id (spec.get ecs)


{-| -}
insert : ComponentSpec comparable ecs a -> comparable -> a -> ecs -> ecs
insert (ComponentSpec spec) id a ecs =
    spec.update (\dict -> Dict.insert id a dict) ecs


{-| -}
update :
    ComponentSpec comparable ecs a
    -> comparable
    -> (Maybe a -> Maybe a)
    -> ecs
    -> ecs
update (ComponentSpec spec) id fn ecs =
    spec.update (\dict -> Dict.update id fn dict) ecs


{-| -}
remove : ComponentSpec comparable ecs a -> comparable -> ecs -> ecs
remove (ComponentSpec spec) id ecs =
    spec.update (\dict -> Dict.remove id dict) ecs


{-| -}
size : ComponentSpec comparable ecs a -> ecs -> Int
size (ComponentSpec spec) ecs =
    Dict.size (spec.get ecs)



-- APPLY SELECTORS --


{-| -}
select : Selector comparable ecs a -> comparable -> ecs -> Maybe a
select (Selector selector) id ecs =
    selector.select id ecs


{-| -}
selectList : Selector comparable ecs a -> ecs -> List ( comparable, a )
selectList (Selector selector) ecs =
    selector.selectList ecs

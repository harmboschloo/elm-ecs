module Ecs exposing
    ( empty, isEmpty, entityCount, componentCount, ids
    , member, clear
    , has, get, insert, update, remove
    , select, selectList
    )

{-|

@docs empty, isEmpty, entityCount, componentCount, ids
@docs member, clear
@docs has, get, insert, update, remove
@docs select, selectList

-}

import Dict exposing (Dict)
import Ecs.Internal exposing (ComponentSpec(..), EcsSpec(..), Selector(..))
import Set exposing (Set)


empty : EcsSpec comparable model -> model
empty (EcsSpec root) =
    root.empty


isEmpty : EcsSpec comparable model -> model -> Bool
isEmpty (EcsSpec root) model =
    root.isEmpty model


entityCount : EcsSpec comparable model -> model -> Int
entityCount root model =
    Set.size (ids root model)


componentCount : EcsSpec comparable model -> model -> Int
componentCount (EcsSpec root) model =
    root.componentCount model


ids : EcsSpec comparable model -> model -> Set comparable
ids (EcsSpec root) model =
    root.ids model


member : EcsSpec comparable model -> comparable -> model -> Bool
member (EcsSpec root) id model =
    root.member id model


clear : EcsSpec comparable model -> comparable -> model -> model
clear (EcsSpec root) id model =
    root.clear id model


has : ComponentSpec comparable model data -> comparable -> model -> Bool
has (ComponentSpec component) id model =
    Dict.member id (component.get model)


get : ComponentSpec comparable model data -> comparable -> model -> Maybe data
get (ComponentSpec component) id model =
    Dict.get id (component.get model)


insert : ComponentSpec comparable model data -> comparable -> data -> model -> model
insert (ComponentSpec component) id data model =
    component.update (\dict -> Dict.insert id data dict) model


update :
    ComponentSpec comparable model data
    -> comparable
    -> (Maybe data -> Maybe data)
    -> model
    -> model
update (ComponentSpec component) id fn model =
    component.update (\dict -> Dict.update id fn dict) model


remove : ComponentSpec comparable model data -> comparable -> model -> model
remove (ComponentSpec component) id model =
    component.update (\dict -> Dict.remove id dict) model


select : Selector comparable model data -> comparable -> model -> Maybe data
select (Selector selector) id model =
    selector.select id model


selectList :
    Selector comparable model data
    -> model
    -> List ( comparable, data )
selectList (Selector selector) model =
    selector.selectList model

module Ecs.Api exposing
    ( EcsType
    , empty, isEmpty, entityCount, componentCount, ids
    , member, clear
    , ComponentType
    , has, get, insert, update, remove
    , select, selectList
    )

{-|

@docs EcsType
@docs empty, isEmpty, entityCount, componentCount, ids
@docs member, clear
@docs ComponentType
@docs has, get, insert, update, remove
@docs select, selectList

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal exposing (Selector(..))
import Set exposing (Set)


type alias EcsType comparable model =
    Internal.EcsType comparable model


type alias ComponentType comparable model data =
    Internal.ComponentType comparable model data


empty : EcsType comparable model -> model
empty (Internal.EcsType root) =
    root.empty


isEmpty : EcsType comparable model -> model -> Bool
isEmpty (Internal.EcsType root) model =
    root.isEmpty model


entityCount : EcsType comparable model -> model -> Int
entityCount root model =
    Set.size (ids root model)


componentCount : EcsType comparable model -> model -> Int
componentCount (Internal.EcsType root) model =
    root.componentCount model


ids : EcsType comparable model -> model -> Set comparable
ids (Internal.EcsType root) model =
    root.ids model


member : EcsType comparable model -> comparable -> model -> Bool
member (Internal.EcsType root) id model =
    root.member id model


clear : EcsType comparable model -> comparable -> model -> model
clear (Internal.EcsType root) id model =
    root.clear id model


has : ComponentType comparable model data -> comparable -> model -> Bool
has (Internal.ComponentType component) id model =
    Dict.member id (component.get model)


get : ComponentType comparable model data -> comparable -> model -> Maybe data
get (Internal.ComponentType component) id model =
    Dict.get id (component.get model)


insert : ComponentType comparable model data -> comparable -> data -> model -> model
insert (Internal.ComponentType component) id data model =
    component.update (\dict -> Dict.insert id data dict) model


update :
    ComponentType comparable model data
    -> comparable
    -> (Maybe data -> Maybe data)
    -> model
    -> model
update (Internal.ComponentType component) id fn model =
    component.update (\dict -> Dict.update id fn dict) model


remove : ComponentType comparable model data -> comparable -> model -> model
remove (Internal.ComponentType component) id model =
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

module Ecs.Api exposing
    ( empty, isEmpty, entityCount, componentCount, ids
    , member, clear
    , has, get, insert, update, remove
    , select, selectList
    , Selector, component, select1, select2, select3, select4, select5
    , andGet, andThen, andHas, andNot, andFilter
    )

{-|

@docs empty, isEmpty, entityCount, componentCount, ids
@docs member, clear
@docs has, get, insert, update, remove
@docs select, selectList
@docs Selector, component, select1, select2, select3, select4, select5
@docs andGet, andThen, andHas, andNot, andFilter

-}

import Dict exposing (Dict)
import Ecs.Internal exposing (ComponentSpec(..), Spec(..))
import Ecs.Internal.Select as Select
import Set exposing (Set)



-- MODEL --


{-| -}
empty : Spec componentSpecs comparable model -> model
empty (Spec spec) =
    spec.empty


{-| -}
isEmpty : Spec componentSpecs comparable model -> model -> Bool
isEmpty (Spec spec) model =
    spec.isEmpty model


{-| -}
entityCount : Spec componentSpecs comparable model -> model -> Int
entityCount spec model =
    Set.size (ids spec model)


{-| -}
componentCount : Spec componentSpecs comparable model -> model -> Int
componentCount (Spec spec) model =
    spec.componentCount model


{-| -}
ids : Spec componentSpecs comparable model -> model -> Set comparable
ids (Spec spec) model =
    spec.ids model



-- ENTITY --


{-| -}
member : Spec componentSpecs comparable model -> comparable -> model -> Bool
member (Spec spec) id model =
    spec.member id model


{-| -}
clear : Spec componentSpecs comparable model -> comparable -> model -> model
clear (Spec spec) id model =
    spec.clear id model



-- COMPONENTS --


{-| -}
has :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model data)
    -> comparable
    -> model
    -> Bool
has spec getComponentSpec id model =
    Dict.member id (getComponents spec getComponentSpec model)


{-| -}
get :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model data)
    -> comparable
    -> model
    -> Maybe data
get spec getComponentSpec id model =
    Dict.get id (getComponents spec getComponentSpec model)


{-| -}
insert :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model data)
    -> comparable
    -> data
    -> model
    -> model
insert spec getComponentSpec id data model =
    updateComponents spec getComponentSpec (\dict -> Dict.insert id data dict) model


{-| -}
update :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model data)
    -> comparable
    -> (Maybe data -> Maybe data)
    -> model
    -> model
update spec getComponentSpec id fn model =
    updateComponents spec getComponentSpec (\dict -> Dict.update id fn dict) model


{-| -}
remove :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model data)
    -> comparable
    -> model
    -> model
remove spec getComponentSpec id model =
    updateComponents spec getComponentSpec (\dict -> Dict.remove id dict) model


getComponents :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model data)
    -> model
    -> Dict comparable data
getComponents (Spec spec) getCompnentSpec model =
    let
        (ComponentSpec componentSpec) =
            getCompnentSpec spec.components
    in
    componentSpec.get model


updateComponents :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model data)
    -> (Dict comparable data -> Dict comparable data)
    -> model
    -> model
updateComponents (Spec spec) getCompnentSpec fn model =
    let
        (ComponentSpec componentSpec) =
            getCompnentSpec spec.components
    in
    componentSpec.update fn model



-- APPLY SELECTORS --


{-| -}
select : Selector comparable model data -> comparable -> model -> Maybe data
select (Select.Selector selector) id model =
    selector.select id model


{-| -}
selectList :
    Selector comparable model data
    -> model
    -> List ( comparable, data )
selectList (Select.Selector selector) model =
    selector.selectList model



-- CREATE SELECTORS --


{-| -}
type alias Selector comparable model data =
    Select.Selector comparable model data


{-| -}
component :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> Selector comparable model a
component =
    Select.component


{-| -}
select1 :
    Spec componentSpecs comparable model
    -> (a -> b)
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> Selector comparable model b
select1 =
    Select.select1


{-| -}
select2 :
    Spec componentSpecs comparable model
    -> (a -> b -> c)
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> Selector comparable model c
select2 =
    Select.select2


{-| -}
select3 :
    Spec componentSpecs comparable model
    -> (a -> b -> c -> d)
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> (componentSpecs -> ComponentSpec comparable model c)
    -> Selector comparable model d
select3 =
    Select.select3


{-| -}
select4 :
    Spec componentSpecs comparable model
    -> (a -> b -> c -> d -> e)
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> (componentSpecs -> ComponentSpec comparable model c)
    -> (componentSpecs -> ComponentSpec comparable model d)
    -> Selector comparable model e
select4 =
    Select.select4


{-| -}
select5 :
    Spec componentSpecs comparable model
    -> (a -> b -> c -> d -> e -> f)
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> (componentSpecs -> ComponentSpec comparable model c)
    -> (componentSpecs -> ComponentSpec comparable model d)
    -> (componentSpecs -> ComponentSpec comparable model e)
    -> Selector comparable model f
select5 =
    Select.select5



-- SELECTOR MODIFIERS --


{-| -}
andGet :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> Selector comparable model (Maybe a -> b)
    -> Selector comparable model b
andGet =
    Select.andGet


{-| -}
andThen :
    (a -> Maybe b)
    -> Selector comparable model a
    -> Selector comparable model b
andThen =
    Select.andThen


{-| -}
andHas :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> Selector comparable model a
    -> Selector comparable model a
andHas =
    Select.andHas


{-| -}
andNot :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> Selector comparable model a
    -> Selector comparable model a
andNot =
    Select.andNot


{-| -}
andFilter :
    (a -> Bool)
    -> Selector comparable model a
    -> Selector comparable model a
andFilter =
    Select.andFilter

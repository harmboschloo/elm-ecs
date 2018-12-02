module Ecs.Internal.Select exposing
    ( Selector(..)
    , andFilter
    , andGet
    , andHas
    , andNot
    , andThen
    , component
    , select1
    , select2
    , select3
    , select4
    , select5
    )

import Dict
import Ecs.Internal as Internal exposing (ComponentSpec(..), Spec(..))


type Selector comparable model a
    = Selector
        { select : comparable -> model -> Maybe a
        , selectList : model -> List ( comparable, a )
        }


component :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> Selector comparable model a
component (Spec spec) getComponentSpec =
    let
        (ComponentSpec componentSpec) =
            getComponentSpec spec.components
    in
    Selector
        { select = \id model -> Dict.get id (componentSpec.get model)
        , selectList = \model -> Dict.toList (componentSpec.get model)
        }


select1 :
    Spec componentSpecs comparable model
    -> (a -> b)
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> Selector comparable model b
select1 spec fn getASpec =
    map fn (component spec getASpec)


select2 :
    Spec componentSpecs comparable model
    -> (a -> b -> c)
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> Selector comparable model c
select2 spec fn getASpec getBSpec =
    map2 fn
        (component spec getASpec)
        (component spec getBSpec)


select3 :
    Spec componentSpecs comparable model
    -> (a -> b -> c -> d)
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> (componentSpecs -> ComponentSpec comparable model c)
    -> Selector comparable model d
select3 spec fn getASpec getBSpec getCSpec =
    map3 fn
        (component spec getASpec)
        (component spec getBSpec)
        (component spec getCSpec)


select4 :
    Spec componentSpecs comparable model
    -> (a -> b -> c -> d -> e)
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> (componentSpecs -> ComponentSpec comparable model c)
    -> (componentSpecs -> ComponentSpec comparable model d)
    -> Selector comparable model e
select4 spec fn getASpec getBSpec getCSpec getDSpec =
    map4 fn
        (component spec getASpec)
        (component spec getBSpec)
        (component spec getCSpec)
        (component spec getDSpec)


select5 :
    Spec componentSpecs comparable model
    -> (a -> b -> c -> d -> e -> f)
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> (componentSpecs -> ComponentSpec comparable model c)
    -> (componentSpecs -> ComponentSpec comparable model d)
    -> (componentSpecs -> ComponentSpec comparable model e)
    -> Selector comparable model f
select5 spec fn getASpec getBSpec getCSpec getDSpec getESpec =
    map5 fn
        (component spec getASpec)
        (component spec getBSpec)
        (component spec getCSpec)
        (component spec getDSpec)
        (component spec getESpec)



-- MAPPING --


map : (a -> b) -> Selector comparable model a -> Selector comparable model b
map fn (Selector selector) =
    Selector
        { select =
            \id model ->
                selectAndMap1 fn
                    (Selector selector)
                    id
                    model
        , selectList =
            \model ->
                List.map
                    (\( id, a ) -> ( id, fn a ))
                    (selector.selectList model)
        }


map2 :
    (a -> b -> c)
    -> Selector comparable model a
    -> Selector comparable model b
    -> Selector comparable model c
map2 fn (Selector aSelector) bSelector =
    Selector
        { select =
            \id model ->
                selectAndMap2 fn
                    (Selector aSelector)
                    bSelector
                    id
                    model
        , selectList =
            \model ->
                List.filterMap
                    (\( id, a ) ->
                        case selectAndMap1 (\b -> fn a b) bSelector id model of
                            Nothing ->
                                Nothing

                            Just c ->
                                Just ( id, c )
                    )
                    (aSelector.selectList model)
        }


map3 :
    (a -> b -> c -> d)
    -> Selector comparable model a
    -> Selector comparable model b
    -> Selector comparable model c
    -> Selector comparable model d
map3 fn (Selector aSelector) bSelector cSelector =
    Selector
        { select =
            \id model ->
                selectAndMap3 fn
                    (Selector aSelector)
                    bSelector
                    cSelector
                    id
                    model
        , selectList =
            \model ->
                List.filterMap
                    (\( id, a ) ->
                        case
                            selectAndMap2 (\b c -> fn a b c)
                                bSelector
                                cSelector
                                id
                                model
                        of
                            Nothing ->
                                Nothing

                            Just d ->
                                Just ( id, d )
                    )
                    (aSelector.selectList model)
        }


map4 :
    (a -> b -> c -> d -> e)
    -> Selector comparable model a
    -> Selector comparable model b
    -> Selector comparable model c
    -> Selector comparable model d
    -> Selector comparable model e
map4 fn (Selector aSelector) bSelector cSelector dSelector =
    Selector
        { select =
            \id model ->
                selectAndMap4 fn
                    (Selector aSelector)
                    bSelector
                    cSelector
                    dSelector
                    id
                    model
        , selectList =
            \model ->
                List.filterMap
                    (\( id, a ) ->
                        case
                            selectAndMap3 (\b c d -> fn a b c d)
                                bSelector
                                cSelector
                                dSelector
                                id
                                model
                        of
                            Nothing ->
                                Nothing

                            Just e ->
                                Just ( id, e )
                    )
                    (aSelector.selectList model)
        }


map5 :
    (a -> b -> c -> d -> e -> f)
    -> Selector comparable model a
    -> Selector comparable model b
    -> Selector comparable model c
    -> Selector comparable model d
    -> Selector comparable model e
    -> Selector comparable model f
map5 fn (Selector aSelector) bSelector cSelector dSelector eSelector =
    Selector
        { select =
            \id model ->
                selectAndMap5 fn
                    (Selector aSelector)
                    bSelector
                    cSelector
                    dSelector
                    eSelector
                    id
                    model
        , selectList =
            \model ->
                List.filterMap
                    (\( id, a ) ->
                        case
                            selectAndMap4 (\b c d e -> fn a b c d e)
                                bSelector
                                cSelector
                                dSelector
                                eSelector
                                id
                                model
                        of
                            Nothing ->
                                Nothing

                            Just f ->
                                Just ( id, f )
                    )
                    (aSelector.selectList model)
        }



-- MODIFIERS --


andGet :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model a)
    -> Selector comparable model (Maybe a -> b)
    -> Selector comparable model b
andGet (Spec spec) getComponentSpec (Selector selector) =
    let
        (ComponentSpec componentSpec) =
            getComponentSpec spec.components
    in
    Selector
        { select =
            \id model ->
                case selector.select id model of
                    Nothing ->
                        Nothing

                    Just fn ->
                        Just (fn (Dict.get id (componentSpec.get model)))
        , selectList =
            \model ->
                selector.selectList model
                    |> List.map
                        (\( id, fn ) ->
                            ( id, fn (Dict.get id (componentSpec.get model)) )
                        )
        }


andThen :
    (a -> Maybe b)
    -> Selector comparable model a
    -> Selector comparable model b
andThen fn (Selector selector) =
    Selector
        { select =
            \id model ->
                case selector.select id model of
                    Nothing ->
                        Nothing

                    Just a ->
                        fn a
        , selectList =
            \model ->
                selector.selectList model
                    |> List.filterMap
                        (\( id, a ) ->
                            case fn a of
                                Nothing ->
                                    Nothing

                                Just b ->
                                    Just ( id, b )
                        )
        }


andHas :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> Selector comparable model a
    -> Selector comparable model a
andHas (Spec spec) getComponentSpec (Selector selector) =
    let
        (ComponentSpec componentSpec) =
            getComponentSpec spec.components
    in
    Selector
        { select =
            \id model ->
                case selector.select id model of
                    Nothing ->
                        Nothing

                    Just a ->
                        if Dict.member id (componentSpec.get model) then
                            Just a

                        else
                            Nothing
        , selectList =
            \model ->
                selector.selectList model
                    |> List.filter
                        (\( id, _ ) -> Dict.member id (componentSpec.get model))
        }


andNot :
    Spec componentSpecs comparable model
    -> (componentSpecs -> ComponentSpec comparable model b)
    -> Selector comparable model a
    -> Selector comparable model a
andNot (Spec spec) getComponentSpec (Selector selector) =
    let
        (ComponentSpec componentSpec) =
            getComponentSpec spec.components
    in
    Selector
        { select =
            \id model ->
                case selector.select id model of
                    Nothing ->
                        Nothing

                    Just a ->
                        if Dict.member id (componentSpec.get model) then
                            Nothing

                        else
                            Just a
        , selectList =
            \model ->
                selector.selectList model
                    |> List.filter
                        (\( id, _ ) ->
                            not (Dict.member id (componentSpec.get model))
                        )
        }


andFilter :
    (a -> Bool)
    -> Selector comparable model a
    -> Selector comparable model a
andFilter fn (Selector selector) =
    Selector
        { select =
            \id model ->
                case selector.select id model of
                    Nothing ->
                        Nothing

                    Just a ->
                        if fn a then
                            Just a

                        else
                            Nothing
        , selectList =
            \model ->
                selector.selectList model
                    |> List.filter (\( id, a ) -> fn a)
        }



-- HELPERS --


selectAndMap1 :
    (a -> b)
    -> Selector comparable model a
    -> comparable
    -> model
    -> Maybe b
selectAndMap1 fn (Selector aSelector) id model =
    case aSelector.select id model of
        Nothing ->
            Nothing

        Just a ->
            Just (fn a)


selectAndMap2 :
    (a -> b -> c)
    -> Selector comparable model a
    -> Selector comparable model b
    -> comparable
    -> model
    -> Maybe c
selectAndMap2 fn (Selector aSelector) (Selector bSelector) id model =
    case aSelector.select id model of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select id model of
                Nothing ->
                    Nothing

                Just b ->
                    Just (fn a b)


selectAndMap3 :
    (a -> b -> c -> d)
    -> Selector comparable model a
    -> Selector comparable model b
    -> Selector comparable model c
    -> comparable
    -> model
    -> Maybe d
selectAndMap3 fn (Selector aSelector) (Selector bSelector) (Selector cSelector) id model =
    case aSelector.select id model of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select id model of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select id model of
                        Nothing ->
                            Nothing

                        Just c ->
                            Just (fn a b c)


selectAndMap4 :
    (a -> b -> c -> d -> e)
    -> Selector comparable model a
    -> Selector comparable model b
    -> Selector comparable model c
    -> Selector comparable model d
    -> comparable
    -> model
    -> Maybe e
selectAndMap4 fn (Selector aSelector) (Selector bSelector) (Selector cSelector) (Selector dSelector) id model =
    case aSelector.select id model of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select id model of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select id model of
                        Nothing ->
                            Nothing

                        Just c ->
                            case dSelector.select id model of
                                Nothing ->
                                    Nothing

                                Just d ->
                                    Just (fn a b c d)


selectAndMap5 :
    (a -> b -> c -> d -> e -> f)
    -> Selector comparable model a
    -> Selector comparable model b
    -> Selector comparable model c
    -> Selector comparable model d
    -> Selector comparable model e
    -> comparable
    -> model
    -> Maybe f
selectAndMap5 fn (Selector aSelector) (Selector bSelector) (Selector cSelector) (Selector dSelector) (Selector eSelector) id model =
    case aSelector.select id model of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select id model of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select id model of
                        Nothing ->
                            Nothing

                        Just c ->
                            case dSelector.select id model of
                                Nothing ->
                                    Nothing

                                Just d ->
                                    case eSelector.select id model of
                                        Nothing ->
                                            Nothing

                                        Just e ->
                                            Just (fn a b c d e)

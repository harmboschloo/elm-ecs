module Ecs.Select exposing
    ( Selector, component, select1, select2, select3, select4, select5
    , andGet, andHas, andNot, andThen, andFilter
    )

{-|

@docs Selector, component, select1, select2, select3, select4, select5
@docs andGet, andHas, andNot, andThen, andFilter

-}

import Dict
import Ecs.Internal as Internal exposing (ComponentSpec(..), Spec(..))


type alias Selector comparable ecs a =
    Internal.Selector comparable ecs a


{-| -}
component : ComponentSpec comparable ecs a -> Selector comparable ecs a
component (ComponentSpec spec) =
    Internal.Selector
        { select = \id ecs -> Dict.get id (spec.get ecs)
        , selectList = \ecs -> Dict.toList (spec.get ecs)
        }


{-| -}
select1 :
    (a -> b)
    -> ComponentSpec comparable ecs a
    -> Selector comparable ecs b
select1 fn aSpec =
    map fn (component aSpec)


{-| -}
select2 :
    (a -> b -> c)
    -> ComponentSpec comparable ecs a
    -> ComponentSpec comparable ecs b
    -> Selector comparable ecs c
select2 fn aSpec bSpec =
    map2 fn
        (component aSpec)
        (component bSpec)


{-| -}
select3 :
    (a -> b -> c -> d)
    -> ComponentSpec comparable ecs a
    -> ComponentSpec comparable ecs b
    -> ComponentSpec comparable ecs c
    -> Selector comparable ecs d
select3 fn aSpec bSpec cSpec =
    map3 fn
        (component aSpec)
        (component bSpec)
        (component cSpec)


{-| -}
select4 :
    (a -> b -> c -> d -> e)
    -> ComponentSpec comparable ecs a
    -> ComponentSpec comparable ecs b
    -> ComponentSpec comparable ecs c
    -> ComponentSpec comparable ecs d
    -> Selector comparable ecs e
select4 fn aSpec bSpec cSpec dSpec =
    map4 fn
        (component aSpec)
        (component bSpec)
        (component cSpec)
        (component dSpec)


{-| -}
select5 :
    (a -> b -> c -> d -> e -> f)
    -> ComponentSpec comparable ecs a
    -> ComponentSpec comparable ecs b
    -> ComponentSpec comparable ecs c
    -> ComponentSpec comparable ecs d
    -> ComponentSpec comparable ecs e
    -> Selector comparable ecs f
select5 fn aSpec bSpec cSpec dSpec eSpec =
    map5 fn
        (component aSpec)
        (component bSpec)
        (component cSpec)
        (component dSpec)
        (component eSpec)



-- MAPPING --


map : (a -> b) -> Selector comparable ecs a -> Selector comparable ecs b
map fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \id ecs ->
                selectAndMap1 fn
                    (Internal.Selector selector)
                    id
                    ecs
        , selectList =
            \ecs ->
                List.map
                    (\( id, a ) -> ( id, fn a ))
                    (selector.selectList ecs)
        }


map2 :
    (a -> b -> c)
    -> Selector comparable ecs a
    -> Selector comparable ecs b
    -> Selector comparable ecs c
map2 fn (Internal.Selector aSelector) bSelector =
    Internal.Selector
        { select =
            \id ecs ->
                selectAndMap2 fn
                    (Internal.Selector aSelector)
                    bSelector
                    id
                    ecs
        , selectList =
            \ecs ->
                List.filterMap
                    (\( id, a ) ->
                        case selectAndMap1 (\b -> fn a b) bSelector id ecs of
                            Nothing ->
                                Nothing

                            Just c ->
                                Just ( id, c )
                    )
                    (aSelector.selectList ecs)
        }


map3 :
    (a -> b -> c -> d)
    -> Selector comparable ecs a
    -> Selector comparable ecs b
    -> Selector comparable ecs c
    -> Selector comparable ecs d
map3 fn (Internal.Selector aSelector) bSelector cSelector =
    Internal.Selector
        { select =
            \id ecs ->
                selectAndMap3 fn
                    (Internal.Selector aSelector)
                    bSelector
                    cSelector
                    id
                    ecs
        , selectList =
            \ecs ->
                List.filterMap
                    (\( id, a ) ->
                        case
                            selectAndMap2 (\b c -> fn a b c)
                                bSelector
                                cSelector
                                id
                                ecs
                        of
                            Nothing ->
                                Nothing

                            Just d ->
                                Just ( id, d )
                    )
                    (aSelector.selectList ecs)
        }


map4 :
    (a -> b -> c -> d -> e)
    -> Selector comparable ecs a
    -> Selector comparable ecs b
    -> Selector comparable ecs c
    -> Selector comparable ecs d
    -> Selector comparable ecs e
map4 fn (Internal.Selector aSelector) bSelector cSelector dSelector =
    Internal.Selector
        { select =
            \id ecs ->
                selectAndMap4 fn
                    (Internal.Selector aSelector)
                    bSelector
                    cSelector
                    dSelector
                    id
                    ecs
        , selectList =
            \ecs ->
                List.filterMap
                    (\( id, a ) ->
                        case
                            selectAndMap3 (\b c d -> fn a b c d)
                                bSelector
                                cSelector
                                dSelector
                                id
                                ecs
                        of
                            Nothing ->
                                Nothing

                            Just e ->
                                Just ( id, e )
                    )
                    (aSelector.selectList ecs)
        }


map5 :
    (a -> b -> c -> d -> e -> f)
    -> Selector comparable ecs a
    -> Selector comparable ecs b
    -> Selector comparable ecs c
    -> Selector comparable ecs d
    -> Selector comparable ecs e
    -> Selector comparable ecs f
map5 fn (Internal.Selector aSelector) bSelector cSelector dSelector eSelector =
    Internal.Selector
        { select =
            \id ecs ->
                selectAndMap5 fn
                    (Internal.Selector aSelector)
                    bSelector
                    cSelector
                    dSelector
                    eSelector
                    id
                    ecs
        , selectList =
            \ecs ->
                List.filterMap
                    (\( id, a ) ->
                        case
                            selectAndMap4 (\b c d e -> fn a b c d e)
                                bSelector
                                cSelector
                                dSelector
                                eSelector
                                id
                                ecs
                        of
                            Nothing ->
                                Nothing

                            Just f ->
                                Just ( id, f )
                    )
                    (aSelector.selectList ecs)
        }



-- MODIFIERS --


{-| -}
andGet :
    ComponentSpec comparable ecs a
    -> Selector comparable ecs (Maybe a -> b)
    -> Selector comparable ecs b
andGet (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \id ecs ->
                case selector.select id ecs of
                    Nothing ->
                        Nothing

                    Just fn ->
                        Just (fn (Dict.get id (spec.get ecs)))
        , selectList =
            \ecs ->
                selector.selectList ecs
                    |> List.map
                        (\( id, fn ) ->
                            ( id, fn (Dict.get id (spec.get ecs)) )
                        )
        }


{-| -}
andThen :
    (a -> Maybe b)
    -> Selector comparable ecs a
    -> Selector comparable ecs b
andThen fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \id ecs ->
                case selector.select id ecs of
                    Nothing ->
                        Nothing

                    Just a ->
                        fn a
        , selectList =
            \ecs ->
                selector.selectList ecs
                    |> List.filterMap
                        (\( id, a ) ->
                            case fn a of
                                Nothing ->
                                    Nothing

                                Just b ->
                                    Just ( id, b )
                        )
        }


{-| -}
andHas :
    ComponentSpec comparable ecs b
    -> Selector comparable ecs a
    -> Selector comparable ecs a
andHas (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \id ecs ->
                case selector.select id ecs of
                    Nothing ->
                        Nothing

                    Just a ->
                        if Dict.member id (spec.get ecs) then
                            Just a

                        else
                            Nothing
        , selectList =
            \ecs ->
                selector.selectList ecs
                    |> List.filter (\( id, _ ) -> Dict.member id (spec.get ecs))
        }


{-| -}
andNot :
    ComponentSpec comparable ecs b
    -> Selector comparable ecs a
    -> Selector comparable ecs a
andNot (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \id ecs ->
                case selector.select id ecs of
                    Nothing ->
                        Nothing

                    Just a ->
                        if Dict.member id (spec.get ecs) then
                            Nothing

                        else
                            Just a
        , selectList =
            \ecs ->
                selector.selectList ecs
                    |> List.filter
                        (\( id, _ ) -> not (Dict.member id (spec.get ecs)))
        }


{-| -}
andFilter :
    (a -> Bool)
    -> Selector comparable ecs a
    -> Selector comparable ecs a
andFilter fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \id ecs ->
                case selector.select id ecs of
                    Nothing ->
                        Nothing

                    Just a ->
                        if fn a then
                            Just a

                        else
                            Nothing
        , selectList =
            \ecs ->
                selector.selectList ecs
                    |> List.filter (\( id, a ) -> fn a)
        }



-- HELPERS --


selectAndMap1 :
    (a -> b)
    -> Selector comparable ecs a
    -> comparable
    -> ecs
    -> Maybe b
selectAndMap1 fn (Internal.Selector aSelector) id ecs =
    case aSelector.select id ecs of
        Nothing ->
            Nothing

        Just a ->
            Just (fn a)


selectAndMap2 :
    (a -> b -> c)
    -> Selector comparable ecs a
    -> Selector comparable ecs b
    -> comparable
    -> ecs
    -> Maybe c
selectAndMap2 fn (Internal.Selector aSelector) (Internal.Selector bSelector) id ecs =
    case aSelector.select id ecs of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select id ecs of
                Nothing ->
                    Nothing

                Just b ->
                    Just (fn a b)


selectAndMap3 :
    (a -> b -> c -> d)
    -> Selector comparable ecs a
    -> Selector comparable ecs b
    -> Selector comparable ecs c
    -> comparable
    -> ecs
    -> Maybe d
selectAndMap3 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) id ecs =
    case aSelector.select id ecs of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select id ecs of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select id ecs of
                        Nothing ->
                            Nothing

                        Just c ->
                            Just (fn a b c)


selectAndMap4 :
    (a -> b -> c -> d -> e)
    -> Selector comparable ecs a
    -> Selector comparable ecs b
    -> Selector comparable ecs c
    -> Selector comparable ecs d
    -> comparable
    -> ecs
    -> Maybe e
selectAndMap4 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) (Internal.Selector dSelector) id ecs =
    case aSelector.select id ecs of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select id ecs of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select id ecs of
                        Nothing ->
                            Nothing

                        Just c ->
                            case dSelector.select id ecs of
                                Nothing ->
                                    Nothing

                                Just d ->
                                    Just (fn a b c d)


selectAndMap5 :
    (a -> b -> c -> d -> e -> f)
    -> Selector comparable ecs a
    -> Selector comparable ecs b
    -> Selector comparable ecs c
    -> Selector comparable ecs d
    -> Selector comparable ecs e
    -> comparable
    -> ecs
    -> Maybe f
selectAndMap5 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) (Internal.Selector dSelector) (Internal.Selector eSelector) id ecs =
    case aSelector.select id ecs of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select id ecs of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select id ecs of
                        Nothing ->
                            Nothing

                        Just c ->
                            case dSelector.select id ecs of
                                Nothing ->
                                    Nothing

                                Just d ->
                                    case eSelector.select id ecs of
                                        Nothing ->
                                            Nothing

                                        Just e ->
                                            Just (fn a b c d e)

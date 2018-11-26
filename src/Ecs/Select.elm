module Ecs.Select exposing
    ( Selector, component, select1, select2, select3, select4, select5
    , andThen, andHas, andNot, andFilter
    )

{-|

@docs Selector, component, select1, select2, select3, select4, select5
@docs andThen, andHas, andNot, andFilter

-}

import Dict
import Ecs.Internal as Internal exposing (ComponentType(..))



-- CREATION --


{-| -}
type alias Selector comparable model a =
    Internal.Selector comparable model a


{-| -}
component : ComponentType comparable model a -> Selector comparable model a
component (ComponentType c) =
    Internal.Selector
        { select = \id model -> Dict.get id (c.get model)

        -- TODO check foldl/r
        , selectList = \model -> Dict.toList (c.get model)
        }


select1 :
    (a -> b)
    -> ComponentType comparable model a
    -> Selector comparable model b
select1 fn aType =
    map fn (component aType)


select2 :
    (a -> b -> c)
    -> ComponentType comparable model a
    -> ComponentType comparable model b
    -> Selector comparable model c
select2 fn aType bType =
    map2 fn (component aType) (component bType)


select3 :
    (a -> b -> c -> d)
    -> ComponentType comparable model a
    -> ComponentType comparable model b
    -> ComponentType comparable model c
    -> Selector comparable model d
select3 fn aType bType cType =
    map3 fn (component aType) (component bType) (component cType)


select4 :
    (a -> b -> c -> d -> e)
    -> ComponentType comparable model a
    -> ComponentType comparable model b
    -> ComponentType comparable model c
    -> ComponentType comparable model d
    -> Selector comparable model e
select4 fn aType bType cType dType =
    map4 fn
        (component aType)
        (component bType)
        (component cType)
        (component dType)


select5 :
    (a -> b -> c -> d -> e -> f)
    -> ComponentType comparable model a
    -> ComponentType comparable model b
    -> ComponentType comparable model c
    -> ComponentType comparable model d
    -> ComponentType comparable model e
    -> Selector comparable model f
select5 fn aType bType cType dType eType =
    map5 fn
        (component aType)
        (component bType)
        (component cType)
        (component dType)
        (component eType)



-- MAPPING --


map : (a -> b) -> Selector comparable model a -> Selector comparable model b
map fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \id model ->
                selectAndMap1 fn
                    (Internal.Selector selector)
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
map2 fn (Internal.Selector aSelector) bSelector =
    Internal.Selector
        { select =
            \id model ->
                selectAndMap2 fn
                    (Internal.Selector aSelector)
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
map3 fn (Internal.Selector aSelector) bSelector cSelector =
    Internal.Selector
        { select =
            \id model ->
                selectAndMap3 fn
                    (Internal.Selector aSelector)
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
map4 fn (Internal.Selector aSelector) bSelector cSelector dSelector =
    Internal.Selector
        { select =
            \id model ->
                selectAndMap4 fn
                    (Internal.Selector aSelector)
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
map5 fn (Internal.Selector aSelector) bSelector cSelector dSelector eSelector =
    Internal.Selector
        { select =
            \id model ->
                selectAndMap5 fn
                    (Internal.Selector aSelector)
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


{-| -}
andThen :
    (a -> Maybe b)
    -> Selector comparable model a
    -> Selector comparable model b
andThen fn (Internal.Selector selector) =
    Internal.Selector
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


{-| -}
andHas :
    Internal.Selector comparable model b
    -> Selector comparable model a
    -> Selector comparable model a
andHas (Internal.Selector hasSelector) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \id model ->
                case selector.select id model of
                    Nothing ->
                        Nothing

                    Just a ->
                        case hasSelector.select id model of
                            Nothing ->
                                Nothing

                            Just _ ->
                                Just a
        , selectList =
            \model ->
                selector.selectList model
                    |> List.filter
                        (\( id, _ ) ->
                            case hasSelector.select id model of
                                Nothing ->
                                    False

                                Just _ ->
                                    True
                        )
        }


{-| -}
andNot :
    Internal.Selector comparable model b
    -> Selector comparable model a
    -> Selector comparable model a
andNot (Internal.Selector notSelector) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \id model ->
                case selector.select id model of
                    Nothing ->
                        Nothing

                    Just a ->
                        case notSelector.select id model of
                            Nothing ->
                                Just a

                            Just _ ->
                                Nothing
        , selectList =
            \model ->
                selector.selectList model
                    |> List.filter
                        (\( id, _ ) ->
                            case notSelector.select id model of
                                Nothing ->
                                    True

                                Just _ ->
                                    False
                        )
        }


{-| -}
andFilter :
    (a -> Bool)
    -> Selector comparable model a
    -> Selector comparable model a
andFilter fn (Internal.Selector selector) =
    Internal.Selector
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
selectAndMap1 fn (Internal.Selector aSelector) id model =
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
selectAndMap2 fn (Internal.Selector aSelector) (Internal.Selector bSelector) id model =
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
selectAndMap3 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) id model =
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
selectAndMap4 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) (Internal.Selector dSelector) id model =
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
selectAndMap5 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) (Internal.Selector dSelector) (Internal.Selector eSelector) id model =
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

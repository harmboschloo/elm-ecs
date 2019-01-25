module Ecs.Select exposing
    ( Selector, component, select1, select2, select3, select4, select5
    , andGet, andHas, andNot, andThen, andFilter
    )

{-|


# Create selecors

@docs Selector, component, select1, select2, select3, select4, select5


# Modify selectors

@docs andGet, andHas, andNot, andThen, andFilter

-}

import Dict
import Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , EntityId(..)
        , Spec(..)
        )


{-| A selector of a specific set of components.
-}
type alias Selector ecs a =
    Internal.Selector ecs a


{-| Create a selector for a component type.
-}
component : ComponentSpec ecs a -> Selector ecs a
component (ComponentSpec spec) =
    Internal.Selector
        { select = \entityId ecs -> Dict.get entityId (spec.get ecs)
        , selectList =
            \ecs ->
                Dict.foldr
                    (\entityId data list -> ( EntityId entityId, data ) :: list)
                    []
                    (spec.get ecs)
        }


{-| Create a selector for 1 component type, mapped to the provided function.
-}
select1 :
    (a -> b)
    -> ComponentSpec ecs a
    -> Selector ecs b
select1 fn aSpec =
    map fn (component aSpec)


{-| Create a selector for 2 component types, mapped to the provided function.
-}
select2 :
    (a -> b -> c)
    -> ComponentSpec ecs a
    -> ComponentSpec ecs b
    -> Selector ecs c
select2 fn aSpec bSpec =
    map2 fn
        (component aSpec)
        (component bSpec)


{-| Create a selector for 3 component types, mapped to the provided function.
-}
select3 :
    (a -> b -> c -> d)
    -> ComponentSpec ecs a
    -> ComponentSpec ecs b
    -> ComponentSpec ecs c
    -> Selector ecs d
select3 fn aSpec bSpec cSpec =
    map3 fn
        (component aSpec)
        (component bSpec)
        (component cSpec)


{-| Create a selector for 4 component types, mapped to the provided function.
-}
select4 :
    (a -> b -> c -> d -> e)
    -> ComponentSpec ecs a
    -> ComponentSpec ecs b
    -> ComponentSpec ecs c
    -> ComponentSpec ecs d
    -> Selector ecs e
select4 fn aSpec bSpec cSpec dSpec =
    map4 fn
        (component aSpec)
        (component bSpec)
        (component cSpec)
        (component dSpec)


{-| Create a selector for 5 component types, mapped to the provided function.
-}
select5 :
    (a -> b -> c -> d -> e -> f)
    -> ComponentSpec ecs a
    -> ComponentSpec ecs b
    -> ComponentSpec ecs c
    -> ComponentSpec ecs d
    -> ComponentSpec ecs e
    -> Selector ecs f
select5 fn aSpec bSpec cSpec dSpec eSpec =
    map5 fn
        (component aSpec)
        (component bSpec)
        (component cSpec)
        (component dSpec)
        (component eSpec)



-- MAPPING --


map : (a -> b) -> Selector ecs a -> Selector ecs b
map fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId ecs ->
                selectAndMap1 fn
                    (Internal.Selector selector)
                    entityId
                    ecs
        , selectList =
            \ecs ->
                List.map
                    (\( entityId, a ) -> ( entityId, fn a ))
                    (selector.selectList ecs)
        }


map2 :
    (a -> b -> c)
    -> Selector ecs a
    -> Selector ecs b
    -> Selector ecs c
map2 fn (Internal.Selector aSelector) bSelector =
    Internal.Selector
        { select =
            \entityId ecs ->
                selectAndMap2 fn
                    (Internal.Selector aSelector)
                    bSelector
                    entityId
                    ecs
        , selectList =
            \ecs ->
                List.filterMap
                    (\( EntityId entityId, a ) ->
                        case selectAndMap1 (\b -> fn a b) bSelector entityId ecs of
                            Nothing ->
                                Nothing

                            Just c ->
                                Just ( EntityId entityId, c )
                    )
                    (aSelector.selectList ecs)
        }


map3 :
    (a -> b -> c -> d)
    -> Selector ecs a
    -> Selector ecs b
    -> Selector ecs c
    -> Selector ecs d
map3 fn (Internal.Selector aSelector) bSelector cSelector =
    Internal.Selector
        { select =
            \entityId ecs ->
                selectAndMap3 fn
                    (Internal.Selector aSelector)
                    bSelector
                    cSelector
                    entityId
                    ecs
        , selectList =
            \ecs ->
                List.filterMap
                    (\( EntityId entityId, a ) ->
                        case
                            selectAndMap2 (\b c -> fn a b c)
                                bSelector
                                cSelector
                                entityId
                                ecs
                        of
                            Nothing ->
                                Nothing

                            Just d ->
                                Just ( EntityId entityId, d )
                    )
                    (aSelector.selectList ecs)
        }


map4 :
    (a -> b -> c -> d -> e)
    -> Selector ecs a
    -> Selector ecs b
    -> Selector ecs c
    -> Selector ecs d
    -> Selector ecs e
map4 fn (Internal.Selector aSelector) bSelector cSelector dSelector =
    Internal.Selector
        { select =
            \entityId ecs ->
                selectAndMap4 fn
                    (Internal.Selector aSelector)
                    bSelector
                    cSelector
                    dSelector
                    entityId
                    ecs
        , selectList =
            \ecs ->
                List.filterMap
                    (\( EntityId entityId, a ) ->
                        case
                            selectAndMap3 (\b c d -> fn a b c d)
                                bSelector
                                cSelector
                                dSelector
                                entityId
                                ecs
                        of
                            Nothing ->
                                Nothing

                            Just e ->
                                Just ( EntityId entityId, e )
                    )
                    (aSelector.selectList ecs)
        }


map5 :
    (a -> b -> c -> d -> e -> f)
    -> Selector ecs a
    -> Selector ecs b
    -> Selector ecs c
    -> Selector ecs d
    -> Selector ecs e
    -> Selector ecs f
map5 fn (Internal.Selector aSelector) bSelector cSelector dSelector eSelector =
    Internal.Selector
        { select =
            \entityId ecs ->
                selectAndMap5 fn
                    (Internal.Selector aSelector)
                    bSelector
                    cSelector
                    dSelector
                    eSelector
                    entityId
                    ecs
        , selectList =
            \ecs ->
                List.filterMap
                    (\( EntityId entityId, a ) ->
                        case
                            selectAndMap4 (\b c d e -> fn a b c d e)
                                bSelector
                                cSelector
                                dSelector
                                eSelector
                                entityId
                                ecs
                        of
                            Nothing ->
                                Nothing

                            Just f ->
                                Just ( EntityId entityId, f )
                    )
                    (aSelector.selectList ecs)
        }



-- MODIFIERS --


{-| Also get a specific component type.
-}
andGet :
    ComponentSpec ecs a
    -> Selector ecs (Maybe a -> b)
    -> Selector ecs b
andGet (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId ecs ->
                case selector.select entityId ecs of
                    Nothing ->
                        Nothing

                    Just fn ->
                        Just (fn (Dict.get entityId (spec.get ecs)))
        , selectList =
            \ecs ->
                selector.selectList ecs
                    |> List.map
                        (\( EntityId entityId, fn ) ->
                            ( EntityId entityId
                            , fn (Dict.get entityId (spec.get ecs))
                            )
                        )
        }


{-| Also depend on the previous result.
-}
andThen :
    (a -> Maybe b)
    -> Selector ecs a
    -> Selector ecs b
andThen fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId ecs ->
                case selector.select entityId ecs of
                    Nothing ->
                        Nothing

                    Just a ->
                        fn a
        , selectList =
            \ecs ->
                selector.selectList ecs
                    |> List.filterMap
                        (\( entityId, a ) ->
                            case fn a of
                                Nothing ->
                                    Nothing

                                Just b ->
                                    Just ( entityId, b )
                        )
        }


{-| Also check if a specific component type is present.
-}
andHas :
    ComponentSpec ecs b
    -> Selector ecs a
    -> Selector ecs a
andHas (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId ecs ->
                case selector.select entityId ecs of
                    Nothing ->
                        Nothing

                    Just a ->
                        if Dict.member entityId (spec.get ecs) then
                            Just a

                        else
                            Nothing
        , selectList =
            \ecs ->
                selector.selectList ecs
                    |> List.filter
                        (\( EntityId entityId, _ ) ->
                            Dict.member entityId (spec.get ecs)
                        )
        }


{-| Also check if a specific component type is not present.
-}
andNot :
    ComponentSpec ecs b
    -> Selector ecs a
    -> Selector ecs a
andNot (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId ecs ->
                case selector.select entityId ecs of
                    Nothing ->
                        Nothing

                    Just a ->
                        if Dict.member entityId (spec.get ecs) then
                            Nothing

                        else
                            Just a
        , selectList =
            \ecs ->
                selector.selectList ecs
                    |> List.filter
                        (\( EntityId entityId, _ ) ->
                            not (Dict.member entityId (spec.get ecs))
                        )
        }


{-| Also only keep data that satify the test.
-}
andFilter :
    (a -> Bool)
    -> Selector ecs a
    -> Selector ecs a
andFilter fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId ecs ->
                case selector.select entityId ecs of
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
                    |> List.filter (\( EntityId entityId, a ) -> fn a)
        }



-- HELPERS --


selectAndMap1 :
    (a -> b)
    -> Selector ecs a
    -> Int
    -> ecs
    -> Maybe b
selectAndMap1 fn (Internal.Selector aSelector) entityId ecs =
    case aSelector.select entityId ecs of
        Nothing ->
            Nothing

        Just a ->
            Just (fn a)


selectAndMap2 :
    (a -> b -> c)
    -> Selector ecs a
    -> Selector ecs b
    -> Int
    -> ecs
    -> Maybe c
selectAndMap2 fn (Internal.Selector aSelector) (Internal.Selector bSelector) entityId ecs =
    case aSelector.select entityId ecs of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select entityId ecs of
                Nothing ->
                    Nothing

                Just b ->
                    Just (fn a b)


selectAndMap3 :
    (a -> b -> c -> d)
    -> Selector ecs a
    -> Selector ecs b
    -> Selector ecs c
    -> Int
    -> ecs
    -> Maybe d
selectAndMap3 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) entityId ecs =
    case aSelector.select entityId ecs of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select entityId ecs of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select entityId ecs of
                        Nothing ->
                            Nothing

                        Just c ->
                            Just (fn a b c)


selectAndMap4 :
    (a -> b -> c -> d -> e)
    -> Selector ecs a
    -> Selector ecs b
    -> Selector ecs c
    -> Selector ecs d
    -> Int
    -> ecs
    -> Maybe e
selectAndMap4 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) (Internal.Selector dSelector) entityId ecs =
    case aSelector.select entityId ecs of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select entityId ecs of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select entityId ecs of
                        Nothing ->
                            Nothing

                        Just c ->
                            case dSelector.select entityId ecs of
                                Nothing ->
                                    Nothing

                                Just d ->
                                    Just (fn a b c d)


selectAndMap5 :
    (a -> b -> c -> d -> e -> f)
    -> Selector ecs a
    -> Selector ecs b
    -> Selector ecs c
    -> Selector ecs d
    -> Selector ecs e
    -> Int
    -> ecs
    -> Maybe f
selectAndMap5 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) (Internal.Selector dSelector) (Internal.Selector eSelector) entityId ecs =
    case aSelector.select entityId ecs of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select entityId ecs of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select entityId ecs of
                        Nothing ->
                            Nothing

                        Just c ->
                            case dSelector.select entityId ecs of
                                Nothing ->
                                    Nothing

                                Just d ->
                                    case eSelector.select entityId ecs of
                                        Nothing ->
                                            Nothing

                                        Just e ->
                                            Just (fn a b c d e)

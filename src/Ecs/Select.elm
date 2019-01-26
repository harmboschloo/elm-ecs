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
type alias Selector components a =
    Internal.Selector components a


{-| Create a selector for a component type.
-}
component : ComponentSpec components a -> Selector components a
component (ComponentSpec spec) =
    Internal.Selector
        { select =
            \entityId components -> Dict.get entityId (spec.get components)
        , selectList =
            \components ->
                Dict.foldr
                    (\entityId data list -> ( EntityId entityId, data ) :: list)
                    []
                    (spec.get components)
        }


{-| Create a selector for 1 component type, mapped to the provided function.
-}
select1 :
    (a -> b)
    -> ComponentSpec components a
    -> Selector components b
select1 fn aSpec =
    map fn (component aSpec)


{-| Create a selector for 2 component types, mapped to the provided function.
-}
select2 :
    (a -> b -> c)
    -> ComponentSpec components a
    -> ComponentSpec components b
    -> Selector components c
select2 fn aSpec bSpec =
    map2 fn
        (component aSpec)
        (component bSpec)


{-| Create a selector for 3 component types, mapped to the provided function.
-}
select3 :
    (a -> b -> c -> d)
    -> ComponentSpec components a
    -> ComponentSpec components b
    -> ComponentSpec components c
    -> Selector components d
select3 fn aSpec bSpec cSpec =
    map3 fn
        (component aSpec)
        (component bSpec)
        (component cSpec)


{-| Create a selector for 4 component types, mapped to the provided function.
-}
select4 :
    (a -> b -> c -> d -> e)
    -> ComponentSpec components a
    -> ComponentSpec components b
    -> ComponentSpec components c
    -> ComponentSpec components d
    -> Selector components e
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
    -> ComponentSpec components a
    -> ComponentSpec components b
    -> ComponentSpec components c
    -> ComponentSpec components d
    -> ComponentSpec components e
    -> Selector components f
select5 fn aSpec bSpec cSpec dSpec eSpec =
    map5 fn
        (component aSpec)
        (component bSpec)
        (component cSpec)
        (component dSpec)
        (component eSpec)



-- MAPPING --


map : (a -> b) -> Selector components a -> Selector components b
map fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId components ->
                selectAndMap1 fn
                    (Internal.Selector selector)
                    entityId
                    components
        , selectList =
            \components ->
                List.map
                    (\( entityId, a ) -> ( entityId, fn a ))
                    (selector.selectList components)
        }


map2 :
    (a -> b -> c)
    -> Selector components a
    -> Selector components b
    -> Selector components c
map2 fn (Internal.Selector aSelector) bSelector =
    Internal.Selector
        { select =
            \entityId components ->
                selectAndMap2 fn
                    (Internal.Selector aSelector)
                    bSelector
                    entityId
                    components
        , selectList =
            \components ->
                List.filterMap
                    (\( EntityId entityId, a ) ->
                        case
                            selectAndMap1
                                (\b -> fn a b)
                                bSelector
                                entityId
                                components
                        of
                            Nothing ->
                                Nothing

                            Just c ->
                                Just ( EntityId entityId, c )
                    )
                    (aSelector.selectList components)
        }


map3 :
    (a -> b -> c -> d)
    -> Selector components a
    -> Selector components b
    -> Selector components c
    -> Selector components d
map3 fn (Internal.Selector aSelector) bSelector cSelector =
    Internal.Selector
        { select =
            \entityId components ->
                selectAndMap3 fn
                    (Internal.Selector aSelector)
                    bSelector
                    cSelector
                    entityId
                    components
        , selectList =
            \components ->
                List.filterMap
                    (\( EntityId entityId, a ) ->
                        case
                            selectAndMap2 (\b c -> fn a b c)
                                bSelector
                                cSelector
                                entityId
                                components
                        of
                            Nothing ->
                                Nothing

                            Just d ->
                                Just ( EntityId entityId, d )
                    )
                    (aSelector.selectList components)
        }


map4 :
    (a -> b -> c -> d -> e)
    -> Selector components a
    -> Selector components b
    -> Selector components c
    -> Selector components d
    -> Selector components e
map4 fn (Internal.Selector aSelector) bSelector cSelector dSelector =
    Internal.Selector
        { select =
            \entityId components ->
                selectAndMap4 fn
                    (Internal.Selector aSelector)
                    bSelector
                    cSelector
                    dSelector
                    entityId
                    components
        , selectList =
            \components ->
                List.filterMap
                    (\( EntityId entityId, a ) ->
                        case
                            selectAndMap3 (\b c d -> fn a b c d)
                                bSelector
                                cSelector
                                dSelector
                                entityId
                                components
                        of
                            Nothing ->
                                Nothing

                            Just e ->
                                Just ( EntityId entityId, e )
                    )
                    (aSelector.selectList components)
        }


map5 :
    (a -> b -> c -> d -> e -> f)
    -> Selector components a
    -> Selector components b
    -> Selector components c
    -> Selector components d
    -> Selector components e
    -> Selector components f
map5 fn (Internal.Selector aSelector) bSelector cSelector dSelector eSelector =
    Internal.Selector
        { select =
            \entityId components ->
                selectAndMap5 fn
                    (Internal.Selector aSelector)
                    bSelector
                    cSelector
                    dSelector
                    eSelector
                    entityId
                    components
        , selectList =
            \components ->
                List.filterMap
                    (\( EntityId entityId, a ) ->
                        case
                            selectAndMap4 (\b c d e -> fn a b c d e)
                                bSelector
                                cSelector
                                dSelector
                                eSelector
                                entityId
                                components
                        of
                            Nothing ->
                                Nothing

                            Just f ->
                                Just ( EntityId entityId, f )
                    )
                    (aSelector.selectList components)
        }



-- MODIFIERS --


{-| Also get a specific component type.
-}
andGet :
    ComponentSpec components a
    -> Selector components (Maybe a -> b)
    -> Selector components b
andGet (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId components ->
                case selector.select entityId components of
                    Nothing ->
                        Nothing

                    Just fn ->
                        Just (fn (Dict.get entityId (spec.get components)))
        , selectList =
            \components ->
                selector.selectList components
                    |> List.map
                        (\( EntityId entityId, fn ) ->
                            ( EntityId entityId
                            , fn (Dict.get entityId (spec.get components))
                            )
                        )
        }


{-| Also depend on the previous result.
-}
andThen :
    (a -> Maybe b)
    -> Selector components a
    -> Selector components b
andThen fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId components ->
                case selector.select entityId components of
                    Nothing ->
                        Nothing

                    Just a ->
                        fn a
        , selectList =
            \components ->
                selector.selectList components
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
    ComponentSpec components b
    -> Selector components a
    -> Selector components a
andHas (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId components ->
                case selector.select entityId components of
                    Nothing ->
                        Nothing

                    Just a ->
                        if Dict.member entityId (spec.get components) then
                            Just a

                        else
                            Nothing
        , selectList =
            \components ->
                selector.selectList components
                    |> List.filter
                        (\( EntityId entityId, _ ) ->
                            Dict.member entityId (spec.get components)
                        )
        }


{-| Also check if a specific component type is not present.
-}
andNot :
    ComponentSpec components b
    -> Selector components a
    -> Selector components a
andNot (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId components ->
                case selector.select entityId components of
                    Nothing ->
                        Nothing

                    Just a ->
                        if Dict.member entityId (spec.get components) then
                            Nothing

                        else
                            Just a
        , selectList =
            \components ->
                selector.selectList components
                    |> List.filter
                        (\( EntityId entityId, _ ) ->
                            not (Dict.member entityId (spec.get components))
                        )
        }


{-| Also only keep entities that satify the test.
-}
andFilter :
    (a -> Bool)
    -> Selector components a
    -> Selector components a
andFilter fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId components ->
                case selector.select entityId components of
                    Nothing ->
                        Nothing

                    Just a ->
                        if fn a then
                            Just a

                        else
                            Nothing
        , selectList =
            \components ->
                selector.selectList components
                    |> List.filter (\( EntityId entityId, a ) -> fn a)
        }



-- HELPERS --


selectAndMap1 :
    (a -> b)
    -> Selector components a
    -> Int
    -> components
    -> Maybe b
selectAndMap1 fn (Internal.Selector aSelector) entityId components =
    case aSelector.select entityId components of
        Nothing ->
            Nothing

        Just a ->
            Just (fn a)


selectAndMap2 :
    (a -> b -> c)
    -> Selector components a
    -> Selector components b
    -> Int
    -> components
    -> Maybe c
selectAndMap2 fn (Internal.Selector aSelector) (Internal.Selector bSelector) entityId components =
    case aSelector.select entityId components of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select entityId components of
                Nothing ->
                    Nothing

                Just b ->
                    Just (fn a b)


selectAndMap3 :
    (a -> b -> c -> d)
    -> Selector components a
    -> Selector components b
    -> Selector components c
    -> Int
    -> components
    -> Maybe d
selectAndMap3 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) entityId components =
    case aSelector.select entityId components of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select entityId components of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select entityId components of
                        Nothing ->
                            Nothing

                        Just c ->
                            Just (fn a b c)


selectAndMap4 :
    (a -> b -> c -> d -> e)
    -> Selector components a
    -> Selector components b
    -> Selector components c
    -> Selector components d
    -> Int
    -> components
    -> Maybe e
selectAndMap4 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) (Internal.Selector dSelector) entityId components =
    case aSelector.select entityId components of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select entityId components of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select entityId components of
                        Nothing ->
                            Nothing

                        Just c ->
                            case dSelector.select entityId components of
                                Nothing ->
                                    Nothing

                                Just d ->
                                    Just (fn a b c d)


selectAndMap5 :
    (a -> b -> c -> d -> e -> f)
    -> Selector components a
    -> Selector components b
    -> Selector components c
    -> Selector components d
    -> Selector components e
    -> Int
    -> components
    -> Maybe f
selectAndMap5 fn (Internal.Selector aSelector) (Internal.Selector bSelector) (Internal.Selector cSelector) (Internal.Selector dSelector) (Internal.Selector eSelector) entityId components =
    case aSelector.select entityId components of
        Nothing ->
            Nothing

        Just a ->
            case bSelector.select entityId components of
                Nothing ->
                    Nothing

                Just b ->
                    case cSelector.select entityId components of
                        Nothing ->
                            Nothing

                        Just c ->
                            case dSelector.select entityId components of
                                Nothing ->
                                    Nothing

                                Just d ->
                                    case eSelector.select entityId components of
                                        Nothing ->
                                            Nothing

                                        Just e ->
                                            Just (fn a b c d e)

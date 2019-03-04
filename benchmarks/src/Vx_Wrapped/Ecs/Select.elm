module Vx_Wrapped.Ecs.Select exposing
    ( Selector, component, select1, select2, select3, select4, select5
    , andGet, andHas, andNot, andThen, andFilter
    )

{-|


# Create selecors

@docs Selector, component, select1, select2, select3, select4, select5


# Modify selectors

@docs andGet, andHas, andNot, andThen, andFilter

-}

import Array
import Dict exposing (Dict)
import Vx_Wrapped.Ecs as Ecs
import Vx_Wrapped.Ecs.Internal as Internal
    exposing
        ( ComponentSpec(..)
        , ComponentSpecModel
        , Ecs(..)
        , EntityId(..)
        , Model
        )


{-| A selector of a specific set of components.
-}
type alias Selector data a =
    Internal.Selector data a


{-| Create a selector for a component type.
-}
component : ComponentSpec data a -> Selector data a
component spec =
    Internal.Selector
        { select = \entityId model -> Ecs.get spec (EntityId entityId) (Ecs model)
        , selectList = \model -> Ecs.getAll spec (Ecs model)
        }


{-| Create a selector for 1 component type, mapped to the provided function.
-}
select1 : (a -> b) -> ComponentSpec data a -> Selector data b
select1 fn (ComponentSpec spec) =
    Internal.Selector
        { select =
            \entityId model ->
                Maybe.map
                    fn
                    (Ecs.get
                        (ComponentSpec spec)
                        (EntityId entityId)
                        (Ecs model)
                    )
        , selectList =
            \model ->
                case Array.get spec.id model.containers of
                    Just components ->
                        Dict.foldr
                            (\entityId data list ->
                                case spec.unwrap data of
                                    Just value ->
                                        ( EntityId entityId, fn value ) :: list

                                    Nothing ->
                                        list
                            )
                            []
                            components

                    Nothing ->
                        []
        }


{-| Create a selector for 2 component types, mapped to the provided function.
-}
select2 :
    (a -> b -> c)
    -> ComponentSpec data a
    -> ComponentSpec data b
    -> Selector data c
select2 fn (ComponentSpec specA) (ComponentSpec specB) =
    Internal.Selector
        { select =
            \entityId model ->
                mapComponents2
                    (getValueAndThen2 (unwrap2 specA specB fn) entityId)
                    specA
                    specB
                    model
                    |> Maybe.withDefault Nothing
        , selectList =
            \model ->
                mapComponents2
                    (\componentsA componentsB ->
                        Dict.toList componentsA
                            |> List.filterMap
                                (\( entityId, dataA ) ->
                                    Dict.get entityId componentsB
                                        |> Maybe.andThen
                                            (unwrap2
                                                specA
                                                specB
                                                (\a b -> ( EntityId entityId, fn a b ))
                                                dataA
                                            )
                                 -- TODO BENCHMARK
                                 -- (\dataB ->
                                 --     Maybe.map2
                                 --         (\a b -> ( EntityId entityId, fn a b ))
                                 --         (specA.unwrap dataA)
                                 --         (specB.unwrap dataB)
                                 -- )
                                )
                    )
                    specA
                    specB
                    model
                    |> Maybe.withDefault []
        }


{-| Create a selector for 3 component types, mapped to the provided function.
-}
select3 :
    (a -> b -> c -> d)
    -> ComponentSpec data a
    -> ComponentSpec data b
    -> ComponentSpec data c
    -> Selector data d
select3 fn (ComponentSpec specA) (ComponentSpec specB) (ComponentSpec specC) =
    Internal.Selector
        { select =
            \entityId model ->
                mapComponents3
                    (getValueAndThen3 (unwrap3 specA specB specC fn) entityId)
                    specA
                    specB
                    specC
                    model
                    |> Maybe.withDefault Nothing
        , selectList =
            \model ->
                mapComponents3
                    (\componentsA componentsB componentsC ->
                        Dict.toList componentsA
                            |> List.filterMap
                                (\( entityId, dataA ) ->
                                    getValueAndThen2
                                        (unwrap3
                                            specA
                                            specB
                                            specC
                                            (\a b c -> ( EntityId entityId, fn a b c ))
                                            dataA
                                        )
                                        entityId
                                        componentsB
                                        componentsC
                                )
                    )
                    specA
                    specB
                    specC
                    model
                    |> Maybe.withDefault []
        }


{-| Create a selector for 4 component types, mapped to the provided function.
-}
select4 :
    (a -> b -> c -> d -> e)
    -> ComponentSpec data a
    -> ComponentSpec data b
    -> ComponentSpec data c
    -> ComponentSpec data d
    -> Selector data e
select4 fn (ComponentSpec specA) (ComponentSpec specB) (ComponentSpec specC) (ComponentSpec specD) =
    Internal.Selector
        { select =
            \entityId model ->
                mapComponents4
                    (getValueAndThen4
                        (unwrap4 specA specB specC specD fn)
                        entityId
                    )
                    specA
                    specB
                    specC
                    specD
                    model
                    |> Maybe.withDefault Nothing
        , selectList =
            \model ->
                mapComponents4
                    (\componentsA componentsB componentsC componentsD ->
                        Dict.toList componentsA
                            |> List.filterMap
                                (\( entityId, dataA ) ->
                                    getValueAndThen3
                                        (unwrap4
                                            specA
                                            specB
                                            specC
                                            specD
                                            (\a b c d -> ( EntityId entityId, fn a b c d ))
                                            dataA
                                        )
                                        entityId
                                        componentsB
                                        componentsC
                                        componentsD
                                )
                    )
                    specA
                    specB
                    specC
                    specD
                    model
                    |> Maybe.withDefault []
        }


{-| Create a selector for 5 component types, mapped to the provided function.
-}
select5 :
    (a -> b -> c -> d -> e -> f)
    -> ComponentSpec data a
    -> ComponentSpec data b
    -> ComponentSpec data c
    -> ComponentSpec data d
    -> ComponentSpec data e
    -> Selector data f
select5 fn (ComponentSpec specA) (ComponentSpec specB) (ComponentSpec specC) (ComponentSpec specD) (ComponentSpec specE) =
    Internal.Selector
        { select =
            \entityId model ->
                mapComponents5
                    (getValueAndThen5
                        (unwrap5 specA specB specC specD specE fn)
                        entityId
                    )
                    specA
                    specB
                    specC
                    specD
                    specE
                    model
                    |> Maybe.withDefault Nothing
        , selectList =
            \model ->
                mapComponents5
                    (\componentsA componentsB componentsC componentsD componentsE ->
                        Dict.toList componentsA
                            |> List.filterMap
                                (\( entityId, dataA ) ->
                                    getValueAndThen4
                                        (unwrap5
                                            specA
                                            specB
                                            specC
                                            specD
                                            specE
                                            (\a b c d e -> ( EntityId entityId, fn a b c d e ))
                                            dataA
                                        )
                                        entityId
                                        componentsB
                                        componentsC
                                        componentsD
                                        componentsE
                                )
                    )
                    specA
                    specB
                    specC
                    specD
                    specE
                    model
                    |> Maybe.withDefault []
        }



-- HELPERS --


mapComponents2 :
    (Dict Int data -> Dict Int data -> c)
    -> ComponentSpecModel data a
    -> ComponentSpecModel data b
    -> Model data
    -> Maybe c
mapComponents2 fn specA specB { containers } =
    Maybe.map2 fn
        (Array.get specA.id containers)
        (Array.get specB.id containers)


mapComponents3 :
    (Dict Int data -> Dict Int data -> Dict Int data -> d)
    -> ComponentSpecModel data a
    -> ComponentSpecModel data b
    -> ComponentSpecModel data c
    -> Model data
    -> Maybe d
mapComponents3 fn specA specB specC { containers } =
    Maybe.map3 fn
        (Array.get specA.id containers)
        (Array.get specB.id containers)
        (Array.get specC.id containers)


mapComponents4 :
    (Dict Int data -> Dict Int data -> Dict Int data -> Dict Int data -> e)
    -> ComponentSpecModel data a
    -> ComponentSpecModel data b
    -> ComponentSpecModel data c
    -> ComponentSpecModel data d
    -> Model data
    -> Maybe e
mapComponents4 fn specA specB specC specD { containers } =
    Maybe.map4 fn
        (Array.get specA.id containers)
        (Array.get specB.id containers)
        (Array.get specC.id containers)
        (Array.get specD.id containers)


mapComponents5 :
    (Dict Int data -> Dict Int data -> Dict Int data -> Dict Int data -> Dict Int data -> f)
    -> ComponentSpecModel data a
    -> ComponentSpecModel data b
    -> ComponentSpecModel data c
    -> ComponentSpecModel data d
    -> ComponentSpecModel data e
    -> Model data
    -> Maybe f
mapComponents5 fn specA specB specC specD specE { containers } =
    Maybe.map5 fn
        (Array.get specA.id containers)
        (Array.get specB.id containers)
        (Array.get specC.id containers)
        (Array.get specD.id containers)
        (Array.get specE.id containers)


getValueAndThen2 :
    (data -> data -> Maybe a)
    -> Int
    -> Dict Int data
    -> Dict Int data
    -> Maybe a
getValueAndThen2 fn entityId componentsA componentsB =
    Dict.get entityId componentsA
        |> Maybe.andThen
            (\a ->
                Dict.get entityId componentsB
                    |> Maybe.andThen (fn a)
            )


getValueAndThen3 :
    (data -> data -> data -> Maybe a)
    -> Int
    -> Dict Int data
    -> Dict Int data
    -> Dict Int data
    -> Maybe a
getValueAndThen3 fn entityId componentsA componentsB componentsC =
    Dict.get entityId componentsA
        |> Maybe.andThen
            (\a ->
                Dict.get entityId componentsB
                    |> Maybe.andThen
                        (\b ->
                            Dict.get entityId componentsC
                                |> Maybe.andThen (fn a b)
                        )
            )


getValueAndThen4 :
    (data -> data -> data -> data -> Maybe a)
    -> Int
    -> Dict Int data
    -> Dict Int data
    -> Dict Int data
    -> Dict Int data
    -> Maybe a
getValueAndThen4 fn entityId componentsA componentsB componentsC componentsD =
    Dict.get entityId componentsA
        |> Maybe.andThen
            (\a ->
                Dict.get entityId componentsB
                    |> Maybe.andThen
                        (\b ->
                            Dict.get entityId componentsC
                                |> Maybe.andThen
                                    (\c ->
                                        Dict.get entityId componentsD
                                            |> Maybe.andThen (fn a b c)
                                    )
                        )
            )


getValueAndThen5 :
    (data -> data -> data -> data -> data -> Maybe a)
    -> Int
    -> Dict Int data
    -> Dict Int data
    -> Dict Int data
    -> Dict Int data
    -> Dict Int data
    -> Maybe a
getValueAndThen5 fn entityId componentsA componentsB componentsC componentsD componentsE =
    Dict.get entityId componentsA
        |> Maybe.andThen
            (\a ->
                Dict.get entityId componentsB
                    |> Maybe.andThen
                        (\b ->
                            Dict.get entityId componentsC
                                |> Maybe.andThen
                                    (\c ->
                                        Dict.get entityId componentsD
                                            |> Maybe.andThen
                                                (\d ->
                                                    Dict.get entityId componentsE
                                                        |> Maybe.andThen (fn a b c d)
                                                )
                                    )
                        )
            )


unwrap2 :
    ComponentSpecModel data a
    -> ComponentSpecModel data b
    -> (a -> b -> c)
    -> data
    -> data
    -> Maybe c
unwrap2 specA specB fn a b =
    Maybe.map2 fn
        (specA.unwrap a)
        (specB.unwrap b)


unwrap3 :
    ComponentSpecModel data a
    -> ComponentSpecModel data b
    -> ComponentSpecModel data c
    -> (a -> b -> c -> d)
    -> data
    -> data
    -> data
    -> Maybe d
unwrap3 specA specB specC fn a b c =
    Maybe.map3 fn
        (specA.unwrap a)
        (specB.unwrap b)
        (specC.unwrap c)


unwrap4 :
    ComponentSpecModel data a
    -> ComponentSpecModel data b
    -> ComponentSpecModel data c
    -> ComponentSpecModel data d
    -> (a -> b -> c -> d -> e)
    -> data
    -> data
    -> data
    -> data
    -> Maybe e
unwrap4 specA specB specC specD fn a b c d =
    Maybe.map4 fn
        (specA.unwrap a)
        (specB.unwrap b)
        (specC.unwrap c)
        (specD.unwrap d)


unwrap5 :
    ComponentSpecModel data a
    -> ComponentSpecModel data b
    -> ComponentSpecModel data c
    -> ComponentSpecModel data d
    -> ComponentSpecModel data e
    -> (a -> b -> c -> d -> e -> f)
    -> data
    -> data
    -> data
    -> data
    -> data
    -> Maybe f
unwrap5 specA specB specC specD specE fn a b c d e =
    Maybe.map5 fn
        (specA.unwrap a)
        (specB.unwrap b)
        (specC.unwrap c)
        (specD.unwrap d)
        (specE.unwrap e)



-- MODIFIERS --


{-| Also get a specific component type.
-}
andGet :
    ComponentSpec data a
    -> Selector data (Maybe a -> b)
    -> Selector data b
andGet (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId model ->
                case selector.select entityId model of
                    Just fn ->
                        Just
                            (fn
                                (Ecs.get
                                    (ComponentSpec spec)
                                    (EntityId entityId)
                                    (Ecs model)
                                )
                            )

                    Nothing ->
                        Nothing
        , selectList =
            \model ->
                let
                    mapFn =
                        case Array.get spec.id model.containers of
                            Just components ->
                                \( EntityId entityId, fn ) ->
                                    ( EntityId entityId
                                    , fn
                                        (Dict.get entityId components
                                            |> Maybe.andThen spec.unwrap
                                        )
                                    )

                            Nothing ->
                                \( entity, fn ) -> ( entity, fn Nothing )
                in
                List.map mapFn (selector.selectList model)
        }


{-| Also depend on the previous result.
-}
andThen :
    (a -> Maybe b)
    -> Selector data a
    -> Selector data b
andThen fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId model -> Maybe.andThen fn (selector.select entityId model)
        , selectList =
            \model ->
                selector.selectList model
                    |> List.filterMap
                        (\( entity, a ) ->
                            case fn a of
                                Just b ->
                                    Just ( entity, b )

                                Nothing ->
                                    Nothing
                        )
        }


{-| Also check if a specific component type is present.
-}
andHas :
    ComponentSpec data b
    -> Selector data a
    -> Selector data a
andHas (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId model ->
                case selector.select entityId model of
                    Just a ->
                        if
                            Ecs.has
                                (ComponentSpec spec)
                                (EntityId entityId)
                                (Ecs model)
                        then
                            Just a

                        else
                            Nothing

                    Nothing ->
                        Nothing
        , selectList =
            \model ->
                case Array.get spec.id model.containers of
                    Just components ->
                        List.filter
                            (\( EntityId entityId, _ ) ->
                                Dict.member entityId components
                            )
                            (selector.selectList model)

                    Nothing ->
                        selector.selectList model
        }


{-| Also check if a specific component type is not present.
-}
andNot :
    ComponentSpec data b
    -> Selector data a
    -> Selector data a
andNot (ComponentSpec spec) (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId model ->
                case selector.select entityId model of
                    Nothing ->
                        Nothing

                    Just a ->
                        case Array.get spec.id model.containers of
                            Just components ->
                                if Dict.member entityId components then
                                    Nothing

                                else
                                    Just a

                            Nothing ->
                                Just a
        , selectList =
            \model ->
                case Array.get spec.id model.containers of
                    Just components ->
                        selector.selectList model
                            |> List.filter
                                (\( EntityId entityId, _ ) -> not (Dict.member entityId components))

                    Nothing ->
                        selector.selectList model
        }


{-| Also only keep component that satify the test.
-}
andFilter :
    (a -> Bool)
    -> Selector data a
    -> Selector data a
andFilter fn (Internal.Selector selector) =
    Internal.Selector
        { select =
            \entityId model ->
                case selector.select entityId model of
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
                    |> List.filter (\( entityId, a ) -> fn a)
        }

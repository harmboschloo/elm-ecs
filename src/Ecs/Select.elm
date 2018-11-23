module Ecs.Select exposing
    ( Select
    , NoValue, noValue, isEqual, andThen
    , map, map2, map3, map4, map5
    )

{-|

@docs Select
@docs NoValue, noValue, isEqual, andThen
@docs map, map2, map3, map4, map5

-}


{-| -}
type alias Select a b =
    a -> Maybe b


{-| -}
type NoValue
    = NoValue


{-| -}
noValue : Select a b -> Select a NoValue
noValue get =
    \a ->
        case get a of
            Nothing ->
                Just NoValue

            _ ->
                Nothing


{-| -}
isEqual : b -> Select a b -> Select a b
isEqual value get =
    \a ->
        case get a of
            Nothing ->
                Nothing

            Just b ->
                if b == value then
                    Just b

                else
                    Nothing


{-| -}
map : (b -> c) -> Select a b -> Select a c
map fn get =
    \a ->
        case get a of
            Nothing ->
                Nothing

            Just b ->
                Just (fn b)


{-| -}
andThen : (b -> Maybe c) -> Select a b -> Select a c
andThen fn get =
    \a ->
        case get a of
            Nothing ->
                Nothing

            Just b ->
                fn b


{-| -}
map2 :
    (b -> c -> d)
    -> Select a b
    -> Select a c
    -> Select a d
map2 fn getB getC =
    \a ->
        case getB a of
            Nothing ->
                Nothing

            Just b ->
                case getC a of
                    Nothing ->
                        Nothing

                    Just c ->
                        Just (fn b c)


{-| -}
map3 :
    (b -> c -> d -> e)
    -> Select a b
    -> Select a c
    -> Select a d
    -> Select a e
map3 fn getB getC getD =
    \a ->
        case getB a of
            Nothing ->
                Nothing

            Just b ->
                case getC a of
                    Nothing ->
                        Nothing

                    Just c ->
                        case getD a of
                            Nothing ->
                                Nothing

                            Just d ->
                                Just (fn b c d)


{-| -}
map4 :
    (b -> c -> d -> e -> f)
    -> Select a b
    -> Select a c
    -> Select a d
    -> Select a e
    -> Select a f
map4 fn getB getC getD getE =
    \a ->
        case getB a of
            Nothing ->
                Nothing

            Just b ->
                case getC a of
                    Nothing ->
                        Nothing

                    Just c ->
                        case getD a of
                            Nothing ->
                                Nothing

                            Just d ->
                                case getE a of
                                    Nothing ->
                                        Nothing

                                    Just e ->
                                        Just (fn b c d e)


{-| -}
map5 :
    (b -> c -> d -> e -> f -> g)
    -> Select a b
    -> Select a c
    -> Select a d
    -> Select a e
    -> Select a f
    -> Select a g
map5 fn getB getC getD getE getF =
    \a ->
        case getB a of
            Nothing ->
                Nothing

            Just b ->
                case getC a of
                    Nothing ->
                        Nothing

                    Just c ->
                        case getD a of
                            Nothing ->
                                Nothing

                            Just d ->
                                case getE a of
                                    Nothing ->
                                        Nothing

                                    Just e ->
                                        case getF a of
                                            Nothing ->
                                                Nothing

                                            Just f ->
                                                Just (fn b c d e f)

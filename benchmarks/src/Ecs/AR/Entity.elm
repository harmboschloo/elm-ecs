module Ecs.AR.Entity exposing
    ( member, get, set, remove, update
    , empty1, empty2, empty3, empty4, empty5, empty6, empty7, empty8, empty9, empty10, empty11, empty12, empty13, empty14, empty15, empty16, empty17, empty18, empty19, empty20, empty21, empty22, empty23, empty24, empty25, empty26, empty27, empty28, empty29, empty30, empty31, empty32, empty33, empty34, empty35, empty36, empty37, empty38, empty39, empty40, empty41, empty42, empty43, empty44, empty45, empty46, empty47, empty48, empty49, empty50
    )

{-|

@docs member, get, set, remove, update
@docs empty1, empty2, empty3, empty4, empty5, empty6, empty7, empty8, empty9, empty10, empty11, empty12, empty13, empty14, empty15, empty16, empty17, empty18, empty19, empty20, empty21, empty22, empty23, empty24, empty25, empty26, empty27, empty28, empty29, empty30, empty31, empty32, empty33, empty34, empty35, empty36, empty37, empty38, empty39, empty40, empty41, empty42, empty43, empty44, empty45, empty46, empty47, empty48, empty49, empty50

-}

import Ecs.AR.Update exposing (Update)


{-| -}
member : (a -> Maybe b) -> a -> Bool
member getB a =
    case getB a of
        Nothing ->
            False

        Just _ ->
            True


{-| -}
get : (a -> Maybe b) -> a -> Maybe b
get getB a =
    getB a


{-| -}
set : Update a b -> b -> a -> a
set setB b a =
    setB (Just b) a


{-| -}
remove : Update a b -> a -> a
remove setB a =
    setB Nothing a


{-| -}
update : (a -> Maybe b) -> Update a b -> (Maybe b -> Maybe b) -> a -> a
update getB setB fn a =
    setB (fn (getB a)) a


{-| -}
empty1 : (Maybe a1 -> a) -> a
empty1 fn =
    fn Nothing


{-| -}
empty2 : (Maybe a1 -> Maybe a2 -> a) -> a
empty2 fn =
    fn Nothing Nothing


{-| -}
empty3 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> a) -> a
empty3 fn =
    fn Nothing Nothing Nothing


{-| -}
empty4 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> a) -> a
empty4 fn =
    fn Nothing Nothing Nothing Nothing


{-| -}
empty5 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> a) -> a
empty5 fn =
    fn Nothing Nothing Nothing Nothing Nothing


{-| -}
empty6 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> a) -> a
empty6 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty7 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> a) -> a
empty7 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty8 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> a) -> a
empty8 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty9 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> a) -> a
empty9 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty10 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> a) -> a
empty10 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty11 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> a) -> a
empty11 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty12 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> a) -> a
empty12 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty13 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> a) -> a
empty13 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty14 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> a) -> a
empty14 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty15 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> a) -> a
empty15 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty16 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> a) -> a
empty16 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty17 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> a) -> a
empty17 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty18 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> a) -> a
empty18 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty19 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> a) -> a
empty19 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty20 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> a) -> a
empty20 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty21 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> a) -> a
empty21 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty22 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> a) -> a
empty22 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty23 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> a) -> a
empty23 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty24 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> a) -> a
empty24 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty25 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> a) -> a
empty25 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty26 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> a) -> a
empty26 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty27 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> a) -> a
empty27 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty28 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> a) -> a
empty28 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty29 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> a) -> a
empty29 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty30 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> a) -> a
empty30 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty31 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> a) -> a
empty31 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty32 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> a) -> a
empty32 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty33 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> a) -> a
empty33 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty34 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> a) -> a
empty34 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty35 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> a) -> a
empty35 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty36 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> a) -> a
empty36 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty37 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> a) -> a
empty37 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty38 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> a) -> a
empty38 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty39 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> a) -> a
empty39 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty40 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> Maybe a40 -> a) -> a
empty40 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty41 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> Maybe a40 -> Maybe a41 -> a) -> a
empty41 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty42 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> Maybe a40 -> Maybe a41 -> Maybe a42 -> a) -> a
empty42 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty43 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> Maybe a40 -> Maybe a41 -> Maybe a42 -> Maybe a43 -> a) -> a
empty43 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty44 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> Maybe a40 -> Maybe a41 -> Maybe a42 -> Maybe a43 -> Maybe a44 -> a) -> a
empty44 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty45 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> Maybe a40 -> Maybe a41 -> Maybe a42 -> Maybe a43 -> Maybe a44 -> Maybe a45 -> a) -> a
empty45 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty46 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> Maybe a40 -> Maybe a41 -> Maybe a42 -> Maybe a43 -> Maybe a44 -> Maybe a45 -> Maybe a46 -> a) -> a
empty46 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty47 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> Maybe a40 -> Maybe a41 -> Maybe a42 -> Maybe a43 -> Maybe a44 -> Maybe a45 -> Maybe a46 -> Maybe a47 -> a) -> a
empty47 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty48 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> Maybe a40 -> Maybe a41 -> Maybe a42 -> Maybe a43 -> Maybe a44 -> Maybe a45 -> Maybe a46 -> Maybe a47 -> Maybe a48 -> a) -> a
empty48 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty49 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> Maybe a40 -> Maybe a41 -> Maybe a42 -> Maybe a43 -> Maybe a44 -> Maybe a45 -> Maybe a46 -> Maybe a47 -> Maybe a48 -> Maybe a49 -> a) -> a
empty49 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| -}
empty50 : (Maybe a1 -> Maybe a2 -> Maybe a3 -> Maybe a4 -> Maybe a5 -> Maybe a6 -> Maybe a7 -> Maybe a8 -> Maybe a9 -> Maybe a10 -> Maybe a11 -> Maybe a12 -> Maybe a13 -> Maybe a14 -> Maybe a15 -> Maybe a16 -> Maybe a17 -> Maybe a18 -> Maybe a19 -> Maybe a20 -> Maybe a21 -> Maybe a22 -> Maybe a23 -> Maybe a24 -> Maybe a25 -> Maybe a26 -> Maybe a27 -> Maybe a28 -> Maybe a29 -> Maybe a30 -> Maybe a31 -> Maybe a32 -> Maybe a33 -> Maybe a34 -> Maybe a35 -> Maybe a36 -> Maybe a37 -> Maybe a38 -> Maybe a39 -> Maybe a40 -> Maybe a41 -> Maybe a42 -> Maybe a43 -> Maybe a44 -> Maybe a45 -> Maybe a46 -> Maybe a47 -> Maybe a48 -> Maybe a49 -> Maybe a50 -> a) -> a
empty50 fn =
    fn Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing

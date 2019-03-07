module Ecs.Singletons33 exposing (Singletons33, init, specs)

{-|

@docs Singletons33, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 33 singletons.
-}
type Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33
    = Singletons33
        { a1 : a1
        , a2 : a2
        , a3 : a3
        , a4 : a4
        , a5 : a5
        , a6 : a6
        , a7 : a7
        , a8 : a8
        , a9 : a9
        , a10 : a10
        , a11 : a11
        , a12 : a12
        , a13 : a13
        , a14 : a14
        , a15 : a15
        , a16 : a16
        , a17 : a17
        , a18 : a18
        , a19 : a19
        , a20 : a20
        , a21 : a21
        , a22 : a22
        , a23 : a23
        , a24 : a24
        , a25 : a25
        , a26 : a26
        , a27 : a27
        , a28 : a28
        , a29 : a29
        , a30 : a30
        , a31 : a31
        , a32 : a32
        , a33 : a33
        }


{-| Initialize a singleton type for 33 singletons.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> a11 -> a12 -> a13 -> a14 -> a15 -> a16 -> a17 -> a18 -> a19 -> a20 -> a21 -> a22 -> a23 -> a24 -> a25 -> a26 -> a27 -> a28 -> a29 -> a30 -> a31 -> a32 -> a33 -> Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33
init a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 =
    Singletons33
        { a1 = a1
        , a2 = a2
        , a3 = a3
        , a4 = a4
        , a5 = a5
        , a6 = a6
        , a7 = a7
        , a8 = a8
        , a9 = a9
        , a10 = a10
        , a11 = a11
        , a12 = a12
        , a13 = a13
        , a14 = a14
        , a15 = a15
        , a16 = a16
        , a17 = a17
        , a18 = a18
        , a19 = a19
        , a20 = a20
        , a21 = a21
        , a22 = a22
        , a23 = a23
        , a24 = a24
        , a25 = a25
        , a26 = a26
        , a27 = a27
        , a28 = a28
        , a29 = a29
        , a30 = a30
        , a31 = a31
        , a32 = a32
        , a33 = a33
        }


{-| Create all singleton specifications for 33 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a2 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a3 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a4 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a5 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a6 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a7 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a8 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a9 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a10 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a11 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a12 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a13 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a14 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a15 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a16 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a17 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a18 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a19 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a20 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a21 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a22 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a23 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a24 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a25 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a26 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a27 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a28 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a29 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a30 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a31 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a32 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> SingletonSpec a33 (Singletons33 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a1
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = a
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a2
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = a
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a3
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = a
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a4
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = a
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a5
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = a
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a6
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = a
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a7
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = a
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a8
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = a
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a9
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = a
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a10
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = a
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a11
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = a
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a12
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = a
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a13
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = a
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a14
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = a
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a15
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = a
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a16
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = a
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a17
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = a
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a18
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = a
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a19
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = a
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a20
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = a
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a21
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = a
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a22
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = a
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a23
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = a
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a24
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = a
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a25
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = a
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a26
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = a
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a27
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = a
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a28
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = a
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a29
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = a
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a30
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = a
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a31
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = a
                        , a32 = singletons.a32
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a32
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = a
                        , a33 = singletons.a33
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons33 singletons) -> singletons.a33
            , set =
                \a (Singletons33 singletons) ->
                    Singletons33
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        , a10 = singletons.a10
                        , a11 = singletons.a11
                        , a12 = singletons.a12
                        , a13 = singletons.a13
                        , a14 = singletons.a14
                        , a15 = singletons.a15
                        , a16 = singletons.a16
                        , a17 = singletons.a17
                        , a18 = singletons.a18
                        , a19 = singletons.a19
                        , a20 = singletons.a20
                        , a21 = singletons.a21
                        , a22 = singletons.a22
                        , a23 = singletons.a23
                        , a24 = singletons.a24
                        , a25 = singletons.a25
                        , a26 = singletons.a26
                        , a27 = singletons.a27
                        , a28 = singletons.a28
                        , a29 = singletons.a29
                        , a30 = singletons.a30
                        , a31 = singletons.a31
                        , a32 = singletons.a32
                        , a33 = a
                        }
            }
        )

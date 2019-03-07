module Ecs.Singletons32 exposing (Singletons32, init, specs)

{-|

@docs Singletons32, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 32 singletons.
-}
type Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32
    = Singletons32
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
        }


{-| Initialize a singleton type for 32 singletons.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> a11 -> a12 -> a13 -> a14 -> a15 -> a16 -> a17 -> a18 -> a19 -> a20 -> a21 -> a22 -> a23 -> a24 -> a25 -> a26 -> a27 -> a28 -> a29 -> a30 -> a31 -> a32 -> Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32
init a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 =
    Singletons32
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
        }


{-| Create all singleton specifications for 32 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a2 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a3 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a4 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a5 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a6 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a7 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a8 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a9 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a10 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a11 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a12 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a13 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a14 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a15 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a16 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a17 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a18 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a19 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a20 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a21 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a22 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a23 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a24 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a25 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a26 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a27 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a28 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a29 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a30 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a31 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> SingletonSpec a32 (Singletons32 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a1
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a2
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a3
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a4
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a5
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a6
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a7
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a8
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a9
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a10
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a11
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a12
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a13
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a14
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a15
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a16
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a17
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a18
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a19
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a20
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a21
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a22
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a23
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a24
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a25
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a26
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a27
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a28
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a29
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a30
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a31
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons32 singletons) -> singletons.a32
            , set =
                \a (Singletons32 singletons) ->
                    Singletons32
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
                        }
            }
        )

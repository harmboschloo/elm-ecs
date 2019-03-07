module Ecs.Singletons21 exposing (Singletons21, init, specs)

{-|

@docs Singletons21, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 21 singletons.
-}
type Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21
    = Singletons21
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
        }


{-| Initialize a singleton type for 21 singletons.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> a11 -> a12 -> a13 -> a14 -> a15 -> a16 -> a17 -> a18 -> a19 -> a20 -> a21 -> Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21
init a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 =
    Singletons21
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
        }


{-| Create all singleton specifications for 21 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a2 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a3 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a4 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a5 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a6 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a7 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a8 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a9 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a10 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a11 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a12 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a13 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a14 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a15 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a16 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a17 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a18 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a19 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a20 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> SingletonSpec a21 (Singletons21 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a1
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a2
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a3
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a4
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a5
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a6
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a7
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a8
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a9
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a10
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a11
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a12
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a13
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a14
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a15
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a16
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a17
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a18
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a19
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a20
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons21 singletons) -> singletons.a21
            , set =
                \a (Singletons21 singletons) ->
                    Singletons21
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
                        }
            }
        )

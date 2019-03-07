module Ecs.Singletons14 exposing (Singletons14, init, specs)

{-|

@docs Singletons14, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 14 singletons.
-}
type Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14
    = Singletons14
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
        }


{-| Initialize a singleton type for 14 singletons.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> a11 -> a12 -> a13 -> a14 -> Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14
init a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 =
    Singletons14
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
        }


{-| Create all singleton specifications for 14 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a2 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a3 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a4 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a5 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a6 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a7 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a8 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a9 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a10 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a11 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a12 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a13 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> SingletonSpec a14 (Singletons14 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a1
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a2
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a3
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a4
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a5
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a6
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a7
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a8
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a9
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a10
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a11
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a12
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a13
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons14 singletons) -> singletons.a14
            , set =
                \a (Singletons14 singletons) ->
                    Singletons14
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
                        }
            }
        )

module Ecs.Singletons18 exposing (Singletons18, init, specs)

{-|

@docs Singletons18, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A container type for 18 singleton types.
-}
type Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18
    = Singletons18
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
        }


{-| Initialize a container type for 18 singleton types.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> a11 -> a12 -> a13 -> a14 -> a15 -> a16 -> a17 -> a18 -> Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18
init a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 =
    Singletons18
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
        }


{-| Create all singleton specifications for 18 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a2 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a3 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a4 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a5 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a6 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a7 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a8 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a9 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a10 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a11 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a12 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a13 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a14 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a15 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a16 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a17 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> SingletonSpec a18 (Singletons18 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a1
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a2
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a3
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a4
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a5
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a6
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a7
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a8
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a9
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a10
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a11
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a12
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a13
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a14
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a15
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a16
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a17
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons18 singletons) -> singletons.a18
            , set =
                \a (Singletons18 singletons) ->
                    Singletons18
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
                        }
            }
        )

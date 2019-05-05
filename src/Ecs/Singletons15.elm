module Ecs.Singletons15 exposing (Singletons15, init, specs)

{-|

@docs Singletons15, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A container type for 15 singleton types.
-}
type Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15
    = Singletons15
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
        }


{-| Initialize a container type for 15 singleton types.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> a11 -> a12 -> a13 -> a14 -> a15 -> Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15
init a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 =
    Singletons15
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
        }


{-| Create all singleton specifications for 15 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a2 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a3 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a4 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a5 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a6 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a7 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a8 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a9 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a10 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a11 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a12 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a13 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a14 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> SingletonSpec a15 (Singletons15 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a1
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a2
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a3
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a4
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a5
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a6
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a7
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a8
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a9
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a10
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a11
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a12
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a13
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a14
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons15 singletons) -> singletons.a15
            , set =
                \a (Singletons15 singletons) ->
                    Singletons15
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
                        }
            }
        )

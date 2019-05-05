module Ecs.Singletons13 exposing (Singletons13, init, specs)

{-|

@docs Singletons13, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A container type for 13 singleton types.
-}
type Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13
    = Singletons13
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
        }


{-| Initialize a container type for 13 singleton types.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> a11 -> a12 -> a13 -> Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13
init a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 =
    Singletons13
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
        }


{-| Create all singleton specifications for 13 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a2 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a3 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a4 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a5 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a6 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a7 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a8 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a9 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a10 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a11 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a12 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> SingletonSpec a13 (Singletons13 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a1
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a2
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a3
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a4
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a5
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a6
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a7
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a8
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a9
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a10
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a11
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a12
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons13 singletons) -> singletons.a13
            , set =
                \a (Singletons13 singletons) ->
                    Singletons13
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
                        }
            }
        )

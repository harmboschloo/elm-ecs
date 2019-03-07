module Ecs.Singletons12 exposing (Singletons12, init, specs)

{-|

@docs Singletons12, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 12 singletons.
-}
type Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12
    = Singletons12
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
        }


{-| Initialize a singleton type for 12 singletons.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> a11 -> a12 -> Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12
init a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 =
    Singletons12
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
        }


{-| Create all singleton specifications for 12 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> SingletonSpec a2 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> SingletonSpec a3 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> SingletonSpec a4 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> SingletonSpec a5 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> SingletonSpec a6 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> SingletonSpec a7 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> SingletonSpec a8 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> SingletonSpec a9 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> SingletonSpec a10 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> SingletonSpec a11 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> SingletonSpec a12 (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a1
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a2
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a3
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a4
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a5
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a6
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a7
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a8
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a9
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a10
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a11
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a12
            , set =
                \a (Singletons12 singletons) ->
                    Singletons12
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
                        }
            }
        )

module Ecs.Singletons9 exposing (Singletons9, init, specs)

{-|

@docs Singletons9, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 9 singletons.
-}
type Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9
    = Singletons9
        { a1 : a1
        , a2 : a2
        , a3 : a3
        , a4 : a4
        , a5 : a5
        , a6 : a6
        , a7 : a7
        , a8 : a8
        , a9 : a9
        }


{-| Initialize a singleton type for 9 singletons.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9
init a1 a2 a3 a4 a5 a6 a7 a8 a9 =
    Singletons9
        { a1 = a1
        , a2 = a2
        , a3 = a3
        , a4 = a4
        , a5 = a5
        , a6 = a6
        , a7 = a7
        , a8 = a8
        , a9 = a9
        }


{-| Create all singleton specifications for 9 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9)
     -> SingletonSpec a2 (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9)
     -> SingletonSpec a3 (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9)
     -> SingletonSpec a4 (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9)
     -> SingletonSpec a5 (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9)
     -> SingletonSpec a6 (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9)
     -> SingletonSpec a7 (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9)
     -> SingletonSpec a8 (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9)
     -> SingletonSpec a9 (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a1
            , set =
                \a (Singletons9 singletons) ->
                    Singletons9
                        { a1 = a
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a2
            , set =
                \a (Singletons9 singletons) ->
                    Singletons9
                        { a1 = singletons.a1
                        , a2 = a
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a3
            , set =
                \a (Singletons9 singletons) ->
                    Singletons9
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = a
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a4
            , set =
                \a (Singletons9 singletons) ->
                    Singletons9
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = a
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a5
            , set =
                \a (Singletons9 singletons) ->
                    Singletons9
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = a
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a6
            , set =
                \a (Singletons9 singletons) ->
                    Singletons9
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = a
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a7
            , set =
                \a (Singletons9 singletons) ->
                    Singletons9
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = a
                        , a8 = singletons.a8
                        , a9 = singletons.a9
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a8
            , set =
                \a (Singletons9 singletons) ->
                    Singletons9
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = a
                        , a9 = singletons.a9
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a9
            , set =
                \a (Singletons9 singletons) ->
                    Singletons9
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        , a9 = a
                        }
            }
        )

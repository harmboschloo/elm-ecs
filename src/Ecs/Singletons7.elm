module Ecs.Singletons7 exposing (Singletons7, init, specs)

{-|

@docs Singletons7, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 7 singletons.
-}
type Singletons7 a1 a2 a3 a4 a5 a6 a7
    = Singletons7
        { a1 : a1
        , a2 : a2
        , a3 : a3
        , a4 : a4
        , a5 : a5
        , a6 : a6
        , a7 : a7
        }


{-| Initialize a singleton type for 7 singletons.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> Singletons7 a1 a2 a3 a4 a5 a6 a7
init a1 a2 a3 a4 a5 a6 a7 =
    Singletons7
        { a1 = a1
        , a2 = a2
        , a3 = a3
        , a4 = a4
        , a5 = a5
        , a6 = a6
        , a7 = a7
        }


{-| Create all singleton specifications for 7 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons7 a1 a2 a3 a4 a5 a6 a7)
     -> SingletonSpec a2 (Singletons7 a1 a2 a3 a4 a5 a6 a7)
     -> SingletonSpec a3 (Singletons7 a1 a2 a3 a4 a5 a6 a7)
     -> SingletonSpec a4 (Singletons7 a1 a2 a3 a4 a5 a6 a7)
     -> SingletonSpec a5 (Singletons7 a1 a2 a3 a4 a5 a6 a7)
     -> SingletonSpec a6 (Singletons7 a1 a2 a3 a4 a5 a6 a7)
     -> SingletonSpec a7 (Singletons7 a1 a2 a3 a4 a5 a6 a7)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a1
            , set =
                \a (Singletons7 singletons) ->
                    Singletons7
                        { a1 = a
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a2
            , set =
                \a (Singletons7 singletons) ->
                    Singletons7
                        { a1 = singletons.a1
                        , a2 = a
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a3
            , set =
                \a (Singletons7 singletons) ->
                    Singletons7
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = a
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a4
            , set =
                \a (Singletons7 singletons) ->
                    Singletons7
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = a
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a5
            , set =
                \a (Singletons7 singletons) ->
                    Singletons7
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = a
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a6
            , set =
                \a (Singletons7 singletons) ->
                    Singletons7
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = a
                        , a7 = singletons.a7
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a7
            , set =
                \a (Singletons7 singletons) ->
                    Singletons7
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = a
                        }
            }
        )

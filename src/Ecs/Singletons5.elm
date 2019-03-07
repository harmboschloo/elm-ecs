module Ecs.Singletons5 exposing (Singletons5, init, specs)

{-|

@docs Singletons5, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 5 singletons.
-}
type Singletons5 a1 a2 a3 a4 a5
    = Singletons5
        { a1 : a1
        , a2 : a2
        , a3 : a3
        , a4 : a4
        , a5 : a5
        }


{-| Initialize a singleton type for 5 singletons.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> Singletons5 a1 a2 a3 a4 a5
init a1 a2 a3 a4 a5 =
    Singletons5
        { a1 = a1
        , a2 = a2
        , a3 = a3
        , a4 = a4
        , a5 = a5
        }


{-| Create all singleton specifications for 5 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons5 a1 a2 a3 a4 a5)
     -> SingletonSpec a2 (Singletons5 a1 a2 a3 a4 a5)
     -> SingletonSpec a3 (Singletons5 a1 a2 a3 a4 a5)
     -> SingletonSpec a4 (Singletons5 a1 a2 a3 a4 a5)
     -> SingletonSpec a5 (Singletons5 a1 a2 a3 a4 a5)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons5 singletons) -> singletons.a1
            , set =
                \a (Singletons5 singletons) ->
                    Singletons5
                        { a1 = a
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons5 singletons) -> singletons.a2
            , set =
                \a (Singletons5 singletons) ->
                    Singletons5
                        { a1 = singletons.a1
                        , a2 = a
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons5 singletons) -> singletons.a3
            , set =
                \a (Singletons5 singletons) ->
                    Singletons5
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = a
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons5 singletons) -> singletons.a4
            , set =
                \a (Singletons5 singletons) ->
                    Singletons5
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = a
                        , a5 = singletons.a5
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons5 singletons) -> singletons.a5
            , set =
                \a (Singletons5 singletons) ->
                    Singletons5
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = a
                        }
            }
        )

module Ecs.Singletons6 exposing (Singletons6, init, specs)

{-|

@docs Singletons6, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A container type for 6 singleton types.
-}
type Singletons6 a1 a2 a3 a4 a5 a6
    = Singletons6
        { a1 : a1
        , a2 : a2
        , a3 : a3
        , a4 : a4
        , a5 : a5
        , a6 : a6
        }


{-| Initialize a container type for 6 singleton types.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> Singletons6 a1 a2 a3 a4 a5 a6
init a1 a2 a3 a4 a5 a6 =
    Singletons6
        { a1 = a1
        , a2 = a2
        , a3 = a3
        , a4 = a4
        , a5 = a5
        , a6 = a6
        }


{-| Create all singleton specifications for 6 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons6 a1 a2 a3 a4 a5 a6)
     -> SingletonSpec a2 (Singletons6 a1 a2 a3 a4 a5 a6)
     -> SingletonSpec a3 (Singletons6 a1 a2 a3 a4 a5 a6)
     -> SingletonSpec a4 (Singletons6 a1 a2 a3 a4 a5 a6)
     -> SingletonSpec a5 (Singletons6 a1 a2 a3 a4 a5 a6)
     -> SingletonSpec a6 (Singletons6 a1 a2 a3 a4 a5 a6)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a1
            , set =
                \a (Singletons6 singletons) ->
                    Singletons6
                        { a1 = a
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a2
            , set =
                \a (Singletons6 singletons) ->
                    Singletons6
                        { a1 = singletons.a1
                        , a2 = a
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a3
            , set =
                \a (Singletons6 singletons) ->
                    Singletons6
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = a
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a4
            , set =
                \a (Singletons6 singletons) ->
                    Singletons6
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = a
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a5
            , set =
                \a (Singletons6 singletons) ->
                    Singletons6
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = a
                        , a6 = singletons.a6
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a6
            , set =
                \a (Singletons6 singletons) ->
                    Singletons6
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = a
                        }
            }
        )

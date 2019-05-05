module Ecs.Singletons8 exposing (Singletons8, init, specs)

{-|

@docs Singletons8, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A container type for 8 singleton types.
-}
type Singletons8 a1 a2 a3 a4 a5 a6 a7 a8
    = Singletons8
        { a1 : a1
        , a2 : a2
        , a3 : a3
        , a4 : a4
        , a5 : a5
        , a6 : a6
        , a7 : a7
        , a8 : a8
        }


{-| Initialize a container type for 8 singleton types.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> Singletons8 a1 a2 a3 a4 a5 a6 a7 a8
init a1 a2 a3 a4 a5 a6 a7 a8 =
    Singletons8
        { a1 = a1
        , a2 = a2
        , a3 = a3
        , a4 = a4
        , a5 = a5
        , a6 = a6
        , a7 = a7
        , a8 = a8
        }


{-| Create all singleton specifications for 8 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8)
     -> SingletonSpec a2 (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8)
     -> SingletonSpec a3 (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8)
     -> SingletonSpec a4 (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8)
     -> SingletonSpec a5 (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8)
     -> SingletonSpec a6 (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8)
     -> SingletonSpec a7 (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8)
     -> SingletonSpec a8 (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a1
            , set =
                \a (Singletons8 singletons) ->
                    Singletons8
                        { a1 = a
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a2
            , set =
                \a (Singletons8 singletons) ->
                    Singletons8
                        { a1 = singletons.a1
                        , a2 = a
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a3
            , set =
                \a (Singletons8 singletons) ->
                    Singletons8
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = a
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a4
            , set =
                \a (Singletons8 singletons) ->
                    Singletons8
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = a
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a5
            , set =
                \a (Singletons8 singletons) ->
                    Singletons8
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = a
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a6
            , set =
                \a (Singletons8 singletons) ->
                    Singletons8
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = a
                        , a7 = singletons.a7
                        , a8 = singletons.a8
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a7
            , set =
                \a (Singletons8 singletons) ->
                    Singletons8
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = a
                        , a8 = singletons.a8
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a8
            , set =
                \a (Singletons8 singletons) ->
                    Singletons8
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        , a5 = singletons.a5
                        , a6 = singletons.a6
                        , a7 = singletons.a7
                        , a8 = a
                        }
            }
        )

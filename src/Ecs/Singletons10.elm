module Ecs.Singletons10 exposing (Singletons10, init, specs)

{-|

@docs Singletons10, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A container type for 10 singleton types.
-}
type Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    = Singletons10
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
        }


{-| Initialize a container type for 10 singleton types.
-}
init : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
init a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 =
    Singletons10
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
        }


{-| Create all singleton specifications for 10 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> SingletonSpec a2 (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> SingletonSpec a3 (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> SingletonSpec a4 (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> SingletonSpec a5 (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> SingletonSpec a6 (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> SingletonSpec a7 (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> SingletonSpec a8 (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> SingletonSpec a9 (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> SingletonSpec a10 (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a1
            , set =
                \a (Singletons10 singletons) ->
                    Singletons10
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a2
            , set =
                \a (Singletons10 singletons) ->
                    Singletons10
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a3
            , set =
                \a (Singletons10 singletons) ->
                    Singletons10
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a4
            , set =
                \a (Singletons10 singletons) ->
                    Singletons10
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a5
            , set =
                \a (Singletons10 singletons) ->
                    Singletons10
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a6
            , set =
                \a (Singletons10 singletons) ->
                    Singletons10
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a7
            , set =
                \a (Singletons10 singletons) ->
                    Singletons10
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a8
            , set =
                \a (Singletons10 singletons) ->
                    Singletons10
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a9
            , set =
                \a (Singletons10 singletons) ->
                    Singletons10
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
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a10
            , set =
                \a (Singletons10 singletons) ->
                    Singletons10
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
                        }
            }
        )

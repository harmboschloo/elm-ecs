module Ecs.Singletons4 exposing (Singletons4, init, specs)

{-|

@docs Singletons4, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 4 singletons.
-}
type Singletons4 a1 a2 a3 a4
    = Singletons4
        { a1 : a1
        , a2 : a2
        , a3 : a3
        , a4 : a4
        }


{-| Initialize a singleton type for 4 singletons.
-}
init : a1 -> a2 -> a3 -> a4 -> Singletons4 a1 a2 a3 a4
init a1 a2 a3 a4 =
    Singletons4
        { a1 = a1
        , a2 = a2
        , a3 = a3
        , a4 = a4
        }


{-| Create all singleton specifications for 4 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons4 a1 a2 a3 a4)
     -> SingletonSpec a2 (Singletons4 a1 a2 a3 a4)
     -> SingletonSpec a3 (Singletons4 a1 a2 a3 a4)
     -> SingletonSpec a4 (Singletons4 a1 a2 a3 a4)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a1
            , set =
                \a (Singletons4 singletons) ->
                    Singletons4
                        { a1 = a
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a2
            , set =
                \a (Singletons4 singletons) ->
                    Singletons4
                        { a1 = singletons.a1
                        , a2 = a
                        , a3 = singletons.a3
                        , a4 = singletons.a4
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a3
            , set =
                \a (Singletons4 singletons) ->
                    Singletons4
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = a
                        , a4 = singletons.a4
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a4
            , set =
                \a (Singletons4 singletons) ->
                    Singletons4
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        , a4 = a
                        }
            }
        )

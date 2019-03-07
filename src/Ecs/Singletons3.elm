module Ecs.Singletons3 exposing (Singletons3, init, specs)

{-|

@docs Singletons3, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 3 singletons.
-}
type Singletons3 a1 a2 a3
    = Singletons3
        { a1 : a1
        , a2 : a2
        , a3 : a3
        }


{-| Initialize a singleton type for 3 singletons.
-}
init : a1 -> a2 -> a3 -> Singletons3 a1 a2 a3
init a1 a2 a3 =
    Singletons3
        { a1 = a1
        , a2 = a2
        , a3 = a3
        }


{-| Create all singleton specifications for 3 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons3 a1 a2 a3)
     -> SingletonSpec a2 (Singletons3 a1 a2 a3)
     -> SingletonSpec a3 (Singletons3 a1 a2 a3)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons3 singletons) -> singletons.a1
            , set =
                \a (Singletons3 singletons) ->
                    Singletons3
                        { a1 = a
                        , a2 = singletons.a2
                        , a3 = singletons.a3
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons3 singletons) -> singletons.a2
            , set =
                \a (Singletons3 singletons) ->
                    Singletons3
                        { a1 = singletons.a1
                        , a2 = a
                        , a3 = singletons.a3
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons3 singletons) -> singletons.a3
            , set =
                \a (Singletons3 singletons) ->
                    Singletons3
                        { a1 = singletons.a1
                        , a2 = singletons.a2
                        , a3 = a
                        }
            }
        )

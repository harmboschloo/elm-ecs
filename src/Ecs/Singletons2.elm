module Ecs.Singletons2 exposing (Singletons2, init, specs)

{-|

@docs Singletons2, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 2 singletons.
-}
type Singletons2 a1 a2
    = Singletons2
        { a1 : a1
        , a2 : a2
        }


{-| Initialize a singleton type for 2 singletons.
-}
init : a1 -> a2 -> Singletons2 a1 a2
init a1 a2 =
    Singletons2
        { a1 = a1
        , a2 = a2
        }


{-| Create all singleton specifications for 2 singleton types.
-}
specs :
    (SingletonSpec a1 (Singletons2 a1 a2)
     -> SingletonSpec a2 (Singletons2 a1 a2)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons2 singletons) -> singletons.a1
            , set =
                \a (Singletons2 singletons) ->
                    Singletons2
                        { a1 = a
                        , a2 = singletons.a2
                        }
            }
        )
        (SingletonSpec
            { get = \(Singletons2 singletons) -> singletons.a2
            , set =
                \a (Singletons2 singletons) ->
                    Singletons2
                        { a1 = singletons.a1
                        , a2 = a
                        }
            }
        )

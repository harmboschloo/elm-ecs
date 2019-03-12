module V2f_CachedEntity.Ecs.Singletons1 exposing (Singletons1, init, specs)

{-|

@docs Singletons1, init, specs

-}

import V2f_CachedEntity.Ecs.Internal exposing (SingletonSpec(..))


{-| A singletons type for 1 singleton.
-}
type Singletons1 a1
    = Singletons1
        { a1 : a1
        }


{-| Initialize a singleton type for 1 singleton.
-}
init : a1 -> Singletons1 a1
init a1 =
    Singletons1
        { a1 = a1
        }


{-| Create all singleton specifications for 1 singleton type.
-}
specs :
    (SingletonSpec a1 (Singletons1 a1)
     -> specs
    )
    -> specs
specs fn =
    fn
        (SingletonSpec
            { get = \(Singletons1 singletons) -> singletons.a1
            , set =
                \a (Singletons1 singletons) ->
                    Singletons1
                        { a1 = a
                        }
            }
        )

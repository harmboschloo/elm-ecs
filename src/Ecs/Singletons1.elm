module Ecs.Singletons1 exposing (Singletons1, init, specs)

{-|

@docs Singletons1, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A container type for 1 singleton type.
-}
type Singletons1 a1
    = Singletons1
        { a1 : a1
        }


{-| Initialize a container type for 1 singleton type.
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

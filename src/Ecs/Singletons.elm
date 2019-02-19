module Ecs.Singletons exposing
    ( SingletonSpec
    , Singletons1, init1, specs1
    , Singletons2, init2, specs2
    , Singletons3, init3, specs3
    , Singletons4, init4, specs4
    , Singletons5, init5, specs5
    , Singletons6, init6, specs6
    , Singletons7, init7, specs7
    , Singletons8, init8, specs8
    , Singletons9, init9, specs9
    , Singletons10, init10, specs10
    , Singletons11, init11, specs11
    , Singletons12, init12, specs12
    )

{-|

@docs SingletonSpec
@docs Singletons1, init1, specs1
@docs Singletons2, init2, specs2
@docs Singletons3, init3, specs3
@docs Singletons4, init4, specs4
@docs Singletons5, init5, specs5
@docs Singletons6, init6, specs6
@docs Singletons7, init7, specs7
@docs Singletons8, init8, specs8
@docs Singletons9, init9, specs9
@docs Singletons10, init10, specs10
@docs Singletons11, init11, specs11
@docs Singletons12, init12, specs12

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
import Ecs.Internal.Record1 as Record1
import Ecs.Internal.Record2 as Record2
import Ecs.Internal.Record3 as Record3
import Ecs.Internal.Record4 as Record4
import Ecs.Internal.Record5 as Record5
import Ecs.Internal.Record6 as Record6
import Ecs.Internal.Record7 as Record7
import Ecs.Internal.Record8 as Record8
import Ecs.Internal.Record9 as Record9
import Ecs.Internal.Record10 as Record10
import Ecs.Internal.Record11 as Record11
import Ecs.Internal.Record12 as Record12


{-| A specification type for a singleton.
-}
type alias SingletonSpec singletons a =
    Internal.SingletonSpec singletons a


{-| A singletons type for 1 singleton.
-}
type Singletons1 a1
    = Singletons1 (Record1.Record a1)


{-| Initialize a singleton type for 1 singleton.
-}
init1 : a1 -> Singletons1 a1
init1 a1 =
    Singletons1
        { a1 = a1
        }


{-| Create all singleton specifications for 1 singleton type.
-}
specs1 :
    (SingletonSpec (Singletons1 a1) a1
     -> specs
    )
    -> specs
specs1 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons1 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons1 singletons) ->
                    Singletons1 (Record1.update1 updateFn singletons)
            }
        )


{-| A singletons type for 2 singletons.
-}
type Singletons2 a1 a2
    = Singletons2 (Record2.Record a1 a2)


{-| Initialize a singleton type for 2 singletons.
-}
init2 : a1 -> a2 -> Singletons2 a1 a2
init2 a1 a2 =
    Singletons2
        { a1 = a1
        , a2 = a2
        }


{-| Create all singleton specifications for 2 singleton types.
-}
specs2 :
    (SingletonSpec (Singletons2 a1 a2) a1
     -> SingletonSpec (Singletons2 a1 a2) a2
     -> specs
    )
    -> specs
specs2 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons2 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons2 singletons) ->
                    Singletons2 (Record2.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons2 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons2 singletons) ->
                    Singletons2 (Record2.update2 updateFn singletons)
            }
        )


{-| A singletons type for 3 singletons.
-}
type Singletons3 a1 a2 a3
    = Singletons3 (Record3.Record a1 a2 a3)


{-| Initialize a singleton type for 3 singletons.
-}
init3 : a1 -> a2 -> a3 -> Singletons3 a1 a2 a3
init3 a1 a2 a3 =
    Singletons3
        { a1 = a1
        , a2 = a2
        , a3 = a3
        }


{-| Create all singleton specifications for 3 singleton types.
-}
specs3 :
    (SingletonSpec (Singletons3 a1 a2 a3) a1
     -> SingletonSpec (Singletons3 a1 a2 a3) a2
     -> SingletonSpec (Singletons3 a1 a2 a3) a3
     -> specs
    )
    -> specs
specs3 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons3 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons3 singletons) ->
                    Singletons3 (Record3.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons3 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons3 singletons) ->
                    Singletons3 (Record3.update2 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons3 singletons) -> singletons.a3
            , update =
                \updateFn (Singletons3 singletons) ->
                    Singletons3 (Record3.update3 updateFn singletons)
            }
        )


{-| A singletons type for 4 singletons.
-}
type Singletons4 a1 a2 a3 a4
    = Singletons4 (Record4.Record a1 a2 a3 a4)


{-| Initialize a singleton type for 4 singletons.
-}
init4 : a1 -> a2 -> a3 -> a4 -> Singletons4 a1 a2 a3 a4
init4 a1 a2 a3 a4 =
    Singletons4
        { a1 = a1
        , a2 = a2
        , a3 = a3
        , a4 = a4
        }


{-| Create all singleton specifications for 4 singleton types.
-}
specs4 :
    (SingletonSpec (Singletons4 a1 a2 a3 a4) a1
     -> SingletonSpec (Singletons4 a1 a2 a3 a4) a2
     -> SingletonSpec (Singletons4 a1 a2 a3 a4) a3
     -> SingletonSpec (Singletons4 a1 a2 a3 a4) a4
     -> specs
    )
    -> specs
specs4 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons4 singletons) ->
                    Singletons4 (Record4.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons4 singletons) ->
                    Singletons4 (Record4.update2 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a3
            , update =
                \updateFn (Singletons4 singletons) ->
                    Singletons4 (Record4.update3 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a4
            , update =
                \updateFn (Singletons4 singletons) ->
                    Singletons4 (Record4.update4 updateFn singletons)
            }
        )


{-| A singletons type for 5 singletons.
-}
type Singletons5 a1 a2 a3 a4 a5
    = Singletons5 (Record5.Record a1 a2 a3 a4 a5)


{-| Initialize a singleton type for 5 singletons.
-}
init5 : a1 -> a2 -> a3 -> a4 -> a5 -> Singletons5 a1 a2 a3 a4 a5
init5 a1 a2 a3 a4 a5 =
    Singletons5
        { a1 = a1
        , a2 = a2
        , a3 = a3
        , a4 = a4
        , a5 = a5
        }


{-| Create all singleton specifications for 5 singleton types.
-}
specs5 :
    (SingletonSpec (Singletons5 a1 a2 a3 a4 a5) a1
     -> SingletonSpec (Singletons5 a1 a2 a3 a4 a5) a2
     -> SingletonSpec (Singletons5 a1 a2 a3 a4 a5) a3
     -> SingletonSpec (Singletons5 a1 a2 a3 a4 a5) a4
     -> SingletonSpec (Singletons5 a1 a2 a3 a4 a5) a5
     -> specs
    )
    -> specs
specs5 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons5 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons5 singletons) ->
                    Singletons5 (Record5.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons5 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons5 singletons) ->
                    Singletons5 (Record5.update2 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons5 singletons) -> singletons.a3
            , update =
                \updateFn (Singletons5 singletons) ->
                    Singletons5 (Record5.update3 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons5 singletons) -> singletons.a4
            , update =
                \updateFn (Singletons5 singletons) ->
                    Singletons5 (Record5.update4 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons5 singletons) -> singletons.a5
            , update =
                \updateFn (Singletons5 singletons) ->
                    Singletons5 (Record5.update5 updateFn singletons)
            }
        )


{-| A singletons type for 6 singletons.
-}
type Singletons6 a1 a2 a3 a4 a5 a6
    = Singletons6 (Record6.Record a1 a2 a3 a4 a5 a6)


{-| Initialize a singleton type for 6 singletons.
-}
init6 : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> Singletons6 a1 a2 a3 a4 a5 a6
init6 a1 a2 a3 a4 a5 a6 =
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
specs6 :
    (SingletonSpec (Singletons6 a1 a2 a3 a4 a5 a6) a1
     -> SingletonSpec (Singletons6 a1 a2 a3 a4 a5 a6) a2
     -> SingletonSpec (Singletons6 a1 a2 a3 a4 a5 a6) a3
     -> SingletonSpec (Singletons6 a1 a2 a3 a4 a5 a6) a4
     -> SingletonSpec (Singletons6 a1 a2 a3 a4 a5 a6) a5
     -> SingletonSpec (Singletons6 a1 a2 a3 a4 a5 a6) a6
     -> specs
    )
    -> specs
specs6 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons6 singletons) ->
                    Singletons6 (Record6.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons6 singletons) ->
                    Singletons6 (Record6.update2 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a3
            , update =
                \updateFn (Singletons6 singletons) ->
                    Singletons6 (Record6.update3 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a4
            , update =
                \updateFn (Singletons6 singletons) ->
                    Singletons6 (Record6.update4 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a5
            , update =
                \updateFn (Singletons6 singletons) ->
                    Singletons6 (Record6.update5 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons6 singletons) -> singletons.a6
            , update =
                \updateFn (Singletons6 singletons) ->
                    Singletons6 (Record6.update6 updateFn singletons)
            }
        )


{-| A singletons type for 7 singletons.
-}
type Singletons7 a1 a2 a3 a4 a5 a6 a7
    = Singletons7 (Record7.Record a1 a2 a3 a4 a5 a6 a7)


{-| Initialize a singleton type for 7 singletons.
-}
init7 : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> Singletons7 a1 a2 a3 a4 a5 a6 a7
init7 a1 a2 a3 a4 a5 a6 a7 =
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
specs7 :
    (SingletonSpec (Singletons7 a1 a2 a3 a4 a5 a6 a7) a1
     -> SingletonSpec (Singletons7 a1 a2 a3 a4 a5 a6 a7) a2
     -> SingletonSpec (Singletons7 a1 a2 a3 a4 a5 a6 a7) a3
     -> SingletonSpec (Singletons7 a1 a2 a3 a4 a5 a6 a7) a4
     -> SingletonSpec (Singletons7 a1 a2 a3 a4 a5 a6 a7) a5
     -> SingletonSpec (Singletons7 a1 a2 a3 a4 a5 a6 a7) a6
     -> SingletonSpec (Singletons7 a1 a2 a3 a4 a5 a6 a7) a7
     -> specs
    )
    -> specs
specs7 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons7 singletons) ->
                    Singletons7 (Record7.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons7 singletons) ->
                    Singletons7 (Record7.update2 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a3
            , update =
                \updateFn (Singletons7 singletons) ->
                    Singletons7 (Record7.update3 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a4
            , update =
                \updateFn (Singletons7 singletons) ->
                    Singletons7 (Record7.update4 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a5
            , update =
                \updateFn (Singletons7 singletons) ->
                    Singletons7 (Record7.update5 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a6
            , update =
                \updateFn (Singletons7 singletons) ->
                    Singletons7 (Record7.update6 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons7 singletons) -> singletons.a7
            , update =
                \updateFn (Singletons7 singletons) ->
                    Singletons7 (Record7.update7 updateFn singletons)
            }
        )


{-| A singletons type for 8 singletons.
-}
type Singletons8 a1 a2 a3 a4 a5 a6 a7 a8
    = Singletons8 (Record8.Record a1 a2 a3 a4 a5 a6 a7 a8)


{-| Initialize a singleton type for 8 singletons.
-}
init8 : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> Singletons8 a1 a2 a3 a4 a5 a6 a7 a8
init8 a1 a2 a3 a4 a5 a6 a7 a8 =
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
specs8 :
    (SingletonSpec (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8) a1
     -> SingletonSpec (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8) a2
     -> SingletonSpec (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8) a3
     -> SingletonSpec (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8) a4
     -> SingletonSpec (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8) a5
     -> SingletonSpec (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8) a6
     -> SingletonSpec (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8) a7
     -> SingletonSpec (Singletons8 a1 a2 a3 a4 a5 a6 a7 a8) a8
     -> specs
    )
    -> specs
specs8 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons8 singletons) ->
                    Singletons8 (Record8.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons8 singletons) ->
                    Singletons8 (Record8.update2 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a3
            , update =
                \updateFn (Singletons8 singletons) ->
                    Singletons8 (Record8.update3 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a4
            , update =
                \updateFn (Singletons8 singletons) ->
                    Singletons8 (Record8.update4 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a5
            , update =
                \updateFn (Singletons8 singletons) ->
                    Singletons8 (Record8.update5 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a6
            , update =
                \updateFn (Singletons8 singletons) ->
                    Singletons8 (Record8.update6 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a7
            , update =
                \updateFn (Singletons8 singletons) ->
                    Singletons8 (Record8.update7 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons8 singletons) -> singletons.a8
            , update =
                \updateFn (Singletons8 singletons) ->
                    Singletons8 (Record8.update8 updateFn singletons)
            }
        )


{-| A singletons type for 9 singletons.
-}
type Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9
    = Singletons9 (Record9.Record a1 a2 a3 a4 a5 a6 a7 a8 a9)


{-| Initialize a singleton type for 9 singletons.
-}
init9 : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9
init9 a1 a2 a3 a4 a5 a6 a7 a8 a9 =
    Singletons9
        { a1 = a1
        , a2 = a2
        , a3 = a3
        , a4 = a4
        , a5 = a5
        , a6 = a6
        , a7 = a7
        , a8 = a8
        , a9 = a9
        }


{-| Create all singleton specifications for 9 singleton types.
-}
specs9 :
    (SingletonSpec (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a1
     -> SingletonSpec (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a2
     -> SingletonSpec (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a3
     -> SingletonSpec (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a4
     -> SingletonSpec (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a5
     -> SingletonSpec (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a6
     -> SingletonSpec (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a7
     -> SingletonSpec (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a8
     -> SingletonSpec (Singletons9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a9
     -> specs
    )
    -> specs
specs9 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons9 singletons) ->
                    Singletons9 (Record9.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons9 singletons) ->
                    Singletons9 (Record9.update2 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a3
            , update =
                \updateFn (Singletons9 singletons) ->
                    Singletons9 (Record9.update3 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a4
            , update =
                \updateFn (Singletons9 singletons) ->
                    Singletons9 (Record9.update4 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a5
            , update =
                \updateFn (Singletons9 singletons) ->
                    Singletons9 (Record9.update5 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a6
            , update =
                \updateFn (Singletons9 singletons) ->
                    Singletons9 (Record9.update6 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a7
            , update =
                \updateFn (Singletons9 singletons) ->
                    Singletons9 (Record9.update7 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a8
            , update =
                \updateFn (Singletons9 singletons) ->
                    Singletons9 (Record9.update8 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons9 singletons) -> singletons.a9
            , update =
                \updateFn (Singletons9 singletons) ->
                    Singletons9 (Record9.update9 updateFn singletons)
            }
        )


{-| A singletons type for 10 singletons.
-}
type Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    = Singletons10 (Record10.Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)


{-| Initialize a singleton type for 10 singletons.
-}
init10 : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
init10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 =
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
specs10 :
    (SingletonSpec (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a1
     -> SingletonSpec (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a2
     -> SingletonSpec (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a3
     -> SingletonSpec (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a4
     -> SingletonSpec (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a5
     -> SingletonSpec (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a6
     -> SingletonSpec (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a7
     -> SingletonSpec (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a8
     -> SingletonSpec (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a9
     -> SingletonSpec (Singletons10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a10
     -> specs
    )
    -> specs
specs10 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons10 singletons) ->
                    Singletons10 (Record10.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons10 singletons) ->
                    Singletons10 (Record10.update2 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a3
            , update =
                \updateFn (Singletons10 singletons) ->
                    Singletons10 (Record10.update3 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a4
            , update =
                \updateFn (Singletons10 singletons) ->
                    Singletons10 (Record10.update4 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a5
            , update =
                \updateFn (Singletons10 singletons) ->
                    Singletons10 (Record10.update5 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a6
            , update =
                \updateFn (Singletons10 singletons) ->
                    Singletons10 (Record10.update6 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a7
            , update =
                \updateFn (Singletons10 singletons) ->
                    Singletons10 (Record10.update7 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a8
            , update =
                \updateFn (Singletons10 singletons) ->
                    Singletons10 (Record10.update8 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a9
            , update =
                \updateFn (Singletons10 singletons) ->
                    Singletons10 (Record10.update9 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons10 singletons) -> singletons.a10
            , update =
                \updateFn (Singletons10 singletons) ->
                    Singletons10 (Record10.update10 updateFn singletons)
            }
        )


{-| A singletons type for 11 singletons.
-}
type Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11
    = Singletons11 (Record11.Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11)


{-| Initialize a singleton type for 11 singletons.
-}
init11 : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> a11 -> Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11
init11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 =
    Singletons11
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
        , a11 = a11
        }


{-| Create all singleton specifications for 11 singleton types.
-}
specs11 :
    (SingletonSpec (Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a1
     -> SingletonSpec (Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a2
     -> SingletonSpec (Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a3
     -> SingletonSpec (Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a4
     -> SingletonSpec (Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a5
     -> SingletonSpec (Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a6
     -> SingletonSpec (Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a7
     -> SingletonSpec (Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a8
     -> SingletonSpec (Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a9
     -> SingletonSpec (Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a10
     -> SingletonSpec (Singletons11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a11
     -> specs
    )
    -> specs
specs11 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons11 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons11 singletons) ->
                    Singletons11 (Record11.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons11 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons11 singletons) ->
                    Singletons11 (Record11.update2 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons11 singletons) -> singletons.a3
            , update =
                \updateFn (Singletons11 singletons) ->
                    Singletons11 (Record11.update3 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons11 singletons) -> singletons.a4
            , update =
                \updateFn (Singletons11 singletons) ->
                    Singletons11 (Record11.update4 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons11 singletons) -> singletons.a5
            , update =
                \updateFn (Singletons11 singletons) ->
                    Singletons11 (Record11.update5 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons11 singletons) -> singletons.a6
            , update =
                \updateFn (Singletons11 singletons) ->
                    Singletons11 (Record11.update6 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons11 singletons) -> singletons.a7
            , update =
                \updateFn (Singletons11 singletons) ->
                    Singletons11 (Record11.update7 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons11 singletons) -> singletons.a8
            , update =
                \updateFn (Singletons11 singletons) ->
                    Singletons11 (Record11.update8 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons11 singletons) -> singletons.a9
            , update =
                \updateFn (Singletons11 singletons) ->
                    Singletons11 (Record11.update9 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons11 singletons) -> singletons.a10
            , update =
                \updateFn (Singletons11 singletons) ->
                    Singletons11 (Record11.update10 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons11 singletons) -> singletons.a11
            , update =
                \updateFn (Singletons11 singletons) ->
                    Singletons11 (Record11.update11 updateFn singletons)
            }
        )


{-| A singletons type for 12 singletons.
-}
type Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12
    = Singletons12 (Record12.Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)


{-| Initialize a singleton type for 12 singletons.
-}
init12 : a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> a10 -> a11 -> a12 -> Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12
init12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 =
    Singletons12
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
        , a11 = a11
        , a12 = a12
        }


{-| Create all singleton specifications for 12 singleton types.
-}
specs12 :
    (SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a1
     -> SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a2
     -> SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a3
     -> SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a4
     -> SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a5
     -> SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a6
     -> SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a7
     -> SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a8
     -> SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a9
     -> SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a10
     -> SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a11
     -> SingletonSpec (Singletons12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a12
     -> specs
    )
    -> specs
specs12 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update2 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a3
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update3 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a4
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update4 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a5
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update5 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a6
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update6 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a7
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update7 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a8
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update8 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a9
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update9 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a10
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update10 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a11
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update11 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons12 singletons) -> singletons.a12
            , update =
                \updateFn (Singletons12 singletons) ->
                    Singletons12 (Record12.update12 updateFn singletons)
            }
        )

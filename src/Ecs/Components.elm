module Ecs.Components exposing
    ( AllComponentsSpec, ComponentSpec
    , Components1, specs1
    , Components2, specs2
    , Components3, specs3
    , Components4, specs4
    , Components5, specs5
    , Components6, specs6
    , Components7, specs7
    , Components8, specs8
    , Components9, specs9
    , Components10, specs10
    , Components11, specs11
    , Components12, specs12
    )

{-|

@docs AllComponentsSpec, ComponentSpec
@docs Components1, specs1
@docs Components2, specs2
@docs Components3, specs3
@docs Components4, specs4
@docs Components5, specs5
@docs Components6, specs6
@docs Components7, specs7
@docs Components8, specs8
@docs Components9, specs9
@docs Components10, specs10
@docs Components11, specs11
@docs Components12, specs12

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


{-| The specification type for all components.
-}
type alias AllComponentsSpec components =
    Internal.AllComponentsSpec components


{-| A specification type for a component.
-}
type alias ComponentSpec components a =
    Internal.ComponentSpec components a


{-| A components type for 1 component.
-}
type Components1 a1
    = Components1 (Record1.Record (Dict Int a1))


{-| Create all component specifications for 1 component type.
-}
specs1 :
    (AllComponentsSpec (Components1 a1)
     -> ComponentSpec (Components1 a1) a1
     -> specs
    )
    -> specs
specs1 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components1
                    { a1 = Dict.empty
                    }
            , clear =
                \entityId (Components1 components) ->
                    Components1
                        { a1 = Dict.remove entityId components.a1
                        }
            , size =
                \(Components1 components) ->
                    Dict.size components.a1
            }
        )
        (Internal.ComponentSpec
            { get = \(Components1 components) -> components.a1
            , update =
                \updateFn (Components1 components) ->
                    Components1 (Record1.update1 updateFn components)
            }
        )


{-| A components type for 2 components.
-}
type Components2 a1 a2
    = Components2 (Record2.Record (Dict Int a1) (Dict Int a2))


{-| Create all component specifications for 2 component types.
-}
specs2 :
    (AllComponentsSpec (Components2 a1 a2)
     -> ComponentSpec (Components2 a1 a2) a1
     -> ComponentSpec (Components2 a1 a2) a2
     -> specs
    )
    -> specs
specs2 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components2
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    }
            , clear =
                \entityId (Components2 components) ->
                    Components2
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        }
            , size =
                \(Components2 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
            }
        )
        (Internal.ComponentSpec
            { get = \(Components2 components) -> components.a1
            , update =
                \updateFn (Components2 components) ->
                    Components2 (Record2.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components2 components) -> components.a2
            , update =
                \updateFn (Components2 components) ->
                    Components2 (Record2.update2 updateFn components)
            }
        )


{-| A components type for 3 components.
-}
type Components3 a1 a2 a3
    = Components3 (Record3.Record (Dict Int a1) (Dict Int a2) (Dict Int a3))


{-| Create all component specifications for 3 component types.
-}
specs3 :
    (AllComponentsSpec (Components3 a1 a2 a3)
     -> ComponentSpec (Components3 a1 a2 a3) a1
     -> ComponentSpec (Components3 a1 a2 a3) a2
     -> ComponentSpec (Components3 a1 a2 a3) a3
     -> specs
    )
    -> specs
specs3 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components3
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    }
            , clear =
                \entityId (Components3 components) ->
                    Components3
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        , a3 = Dict.remove entityId components.a3
                        }
            , size =
                \(Components3 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
                        + Dict.size components.a3
            }
        )
        (Internal.ComponentSpec
            { get = \(Components3 components) -> components.a1
            , update =
                \updateFn (Components3 components) ->
                    Components3 (Record3.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components3 components) -> components.a2
            , update =
                \updateFn (Components3 components) ->
                    Components3 (Record3.update2 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components3 components) -> components.a3
            , update =
                \updateFn (Components3 components) ->
                    Components3 (Record3.update3 updateFn components)
            }
        )


{-| A components type for 4 components.
-}
type Components4 a1 a2 a3 a4
    = Components4 (Record4.Record (Dict Int a1) (Dict Int a2) (Dict Int a3) (Dict Int a4))


{-| Create all component specifications for 4 component types.
-}
specs4 :
    (AllComponentsSpec (Components4 a1 a2 a3 a4)
     -> ComponentSpec (Components4 a1 a2 a3 a4) a1
     -> ComponentSpec (Components4 a1 a2 a3 a4) a2
     -> ComponentSpec (Components4 a1 a2 a3 a4) a3
     -> ComponentSpec (Components4 a1 a2 a3 a4) a4
     -> specs
    )
    -> specs
specs4 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components4
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    , a4 = Dict.empty
                    }
            , clear =
                \entityId (Components4 components) ->
                    Components4
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        , a3 = Dict.remove entityId components.a3
                        , a4 = Dict.remove entityId components.a4
                        }
            , size =
                \(Components4 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
                        + Dict.size components.a3
                        + Dict.size components.a4
            }
        )
        (Internal.ComponentSpec
            { get = \(Components4 components) -> components.a1
            , update =
                \updateFn (Components4 components) ->
                    Components4 (Record4.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components4 components) -> components.a2
            , update =
                \updateFn (Components4 components) ->
                    Components4 (Record4.update2 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components4 components) -> components.a3
            , update =
                \updateFn (Components4 components) ->
                    Components4 (Record4.update3 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components4 components) -> components.a4
            , update =
                \updateFn (Components4 components) ->
                    Components4 (Record4.update4 updateFn components)
            }
        )


{-| A components type for 5 components.
-}
type Components5 a1 a2 a3 a4 a5
    = Components5 (Record5.Record (Dict Int a1) (Dict Int a2) (Dict Int a3) (Dict Int a4) (Dict Int a5))


{-| Create all component specifications for 5 component types.
-}
specs5 :
    (AllComponentsSpec (Components5 a1 a2 a3 a4 a5)
     -> ComponentSpec (Components5 a1 a2 a3 a4 a5) a1
     -> ComponentSpec (Components5 a1 a2 a3 a4 a5) a2
     -> ComponentSpec (Components5 a1 a2 a3 a4 a5) a3
     -> ComponentSpec (Components5 a1 a2 a3 a4 a5) a4
     -> ComponentSpec (Components5 a1 a2 a3 a4 a5) a5
     -> specs
    )
    -> specs
specs5 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components5
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    , a4 = Dict.empty
                    , a5 = Dict.empty
                    }
            , clear =
                \entityId (Components5 components) ->
                    Components5
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        , a3 = Dict.remove entityId components.a3
                        , a4 = Dict.remove entityId components.a4
                        , a5 = Dict.remove entityId components.a5
                        }
            , size =
                \(Components5 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
                        + Dict.size components.a3
                        + Dict.size components.a4
                        + Dict.size components.a5
            }
        )
        (Internal.ComponentSpec
            { get = \(Components5 components) -> components.a1
            , update =
                \updateFn (Components5 components) ->
                    Components5 (Record5.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components5 components) -> components.a2
            , update =
                \updateFn (Components5 components) ->
                    Components5 (Record5.update2 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components5 components) -> components.a3
            , update =
                \updateFn (Components5 components) ->
                    Components5 (Record5.update3 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components5 components) -> components.a4
            , update =
                \updateFn (Components5 components) ->
                    Components5 (Record5.update4 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components5 components) -> components.a5
            , update =
                \updateFn (Components5 components) ->
                    Components5 (Record5.update5 updateFn components)
            }
        )


{-| A components type for 6 components.
-}
type Components6 a1 a2 a3 a4 a5 a6
    = Components6 (Record6.Record (Dict Int a1) (Dict Int a2) (Dict Int a3) (Dict Int a4) (Dict Int a5) (Dict Int a6))


{-| Create all component specifications for 6 component types.
-}
specs6 :
    (AllComponentsSpec (Components6 a1 a2 a3 a4 a5 a6)
     -> ComponentSpec (Components6 a1 a2 a3 a4 a5 a6) a1
     -> ComponentSpec (Components6 a1 a2 a3 a4 a5 a6) a2
     -> ComponentSpec (Components6 a1 a2 a3 a4 a5 a6) a3
     -> ComponentSpec (Components6 a1 a2 a3 a4 a5 a6) a4
     -> ComponentSpec (Components6 a1 a2 a3 a4 a5 a6) a5
     -> ComponentSpec (Components6 a1 a2 a3 a4 a5 a6) a6
     -> specs
    )
    -> specs
specs6 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components6
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    , a4 = Dict.empty
                    , a5 = Dict.empty
                    , a6 = Dict.empty
                    }
            , clear =
                \entityId (Components6 components) ->
                    Components6
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        , a3 = Dict.remove entityId components.a3
                        , a4 = Dict.remove entityId components.a4
                        , a5 = Dict.remove entityId components.a5
                        , a6 = Dict.remove entityId components.a6
                        }
            , size =
                \(Components6 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
                        + Dict.size components.a3
                        + Dict.size components.a4
                        + Dict.size components.a5
                        + Dict.size components.a6
            }
        )
        (Internal.ComponentSpec
            { get = \(Components6 components) -> components.a1
            , update =
                \updateFn (Components6 components) ->
                    Components6 (Record6.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components6 components) -> components.a2
            , update =
                \updateFn (Components6 components) ->
                    Components6 (Record6.update2 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components6 components) -> components.a3
            , update =
                \updateFn (Components6 components) ->
                    Components6 (Record6.update3 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components6 components) -> components.a4
            , update =
                \updateFn (Components6 components) ->
                    Components6 (Record6.update4 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components6 components) -> components.a5
            , update =
                \updateFn (Components6 components) ->
                    Components6 (Record6.update5 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components6 components) -> components.a6
            , update =
                \updateFn (Components6 components) ->
                    Components6 (Record6.update6 updateFn components)
            }
        )


{-| A components type for 7 components.
-}
type Components7 a1 a2 a3 a4 a5 a6 a7
    = Components7 (Record7.Record (Dict Int a1) (Dict Int a2) (Dict Int a3) (Dict Int a4) (Dict Int a5) (Dict Int a6) (Dict Int a7))


{-| Create all component specifications for 7 component types.
-}
specs7 :
    (AllComponentsSpec (Components7 a1 a2 a3 a4 a5 a6 a7)
     -> ComponentSpec (Components7 a1 a2 a3 a4 a5 a6 a7) a1
     -> ComponentSpec (Components7 a1 a2 a3 a4 a5 a6 a7) a2
     -> ComponentSpec (Components7 a1 a2 a3 a4 a5 a6 a7) a3
     -> ComponentSpec (Components7 a1 a2 a3 a4 a5 a6 a7) a4
     -> ComponentSpec (Components7 a1 a2 a3 a4 a5 a6 a7) a5
     -> ComponentSpec (Components7 a1 a2 a3 a4 a5 a6 a7) a6
     -> ComponentSpec (Components7 a1 a2 a3 a4 a5 a6 a7) a7
     -> specs
    )
    -> specs
specs7 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components7
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    , a4 = Dict.empty
                    , a5 = Dict.empty
                    , a6 = Dict.empty
                    , a7 = Dict.empty
                    }
            , clear =
                \entityId (Components7 components) ->
                    Components7
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        , a3 = Dict.remove entityId components.a3
                        , a4 = Dict.remove entityId components.a4
                        , a5 = Dict.remove entityId components.a5
                        , a6 = Dict.remove entityId components.a6
                        , a7 = Dict.remove entityId components.a7
                        }
            , size =
                \(Components7 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
                        + Dict.size components.a3
                        + Dict.size components.a4
                        + Dict.size components.a5
                        + Dict.size components.a6
                        + Dict.size components.a7
            }
        )
        (Internal.ComponentSpec
            { get = \(Components7 components) -> components.a1
            , update =
                \updateFn (Components7 components) ->
                    Components7 (Record7.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components7 components) -> components.a2
            , update =
                \updateFn (Components7 components) ->
                    Components7 (Record7.update2 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components7 components) -> components.a3
            , update =
                \updateFn (Components7 components) ->
                    Components7 (Record7.update3 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components7 components) -> components.a4
            , update =
                \updateFn (Components7 components) ->
                    Components7 (Record7.update4 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components7 components) -> components.a5
            , update =
                \updateFn (Components7 components) ->
                    Components7 (Record7.update5 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components7 components) -> components.a6
            , update =
                \updateFn (Components7 components) ->
                    Components7 (Record7.update6 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components7 components) -> components.a7
            , update =
                \updateFn (Components7 components) ->
                    Components7 (Record7.update7 updateFn components)
            }
        )


{-| A components type for 8 components.
-}
type Components8 a1 a2 a3 a4 a5 a6 a7 a8
    = Components8 (Record8.Record (Dict Int a1) (Dict Int a2) (Dict Int a3) (Dict Int a4) (Dict Int a5) (Dict Int a6) (Dict Int a7) (Dict Int a8))


{-| Create all component specifications for 8 component types.
-}
specs8 :
    (AllComponentsSpec (Components8 a1 a2 a3 a4 a5 a6 a7 a8)
     -> ComponentSpec (Components8 a1 a2 a3 a4 a5 a6 a7 a8) a1
     -> ComponentSpec (Components8 a1 a2 a3 a4 a5 a6 a7 a8) a2
     -> ComponentSpec (Components8 a1 a2 a3 a4 a5 a6 a7 a8) a3
     -> ComponentSpec (Components8 a1 a2 a3 a4 a5 a6 a7 a8) a4
     -> ComponentSpec (Components8 a1 a2 a3 a4 a5 a6 a7 a8) a5
     -> ComponentSpec (Components8 a1 a2 a3 a4 a5 a6 a7 a8) a6
     -> ComponentSpec (Components8 a1 a2 a3 a4 a5 a6 a7 a8) a7
     -> ComponentSpec (Components8 a1 a2 a3 a4 a5 a6 a7 a8) a8
     -> specs
    )
    -> specs
specs8 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components8
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    , a4 = Dict.empty
                    , a5 = Dict.empty
                    , a6 = Dict.empty
                    , a7 = Dict.empty
                    , a8 = Dict.empty
                    }
            , clear =
                \entityId (Components8 components) ->
                    Components8
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        , a3 = Dict.remove entityId components.a3
                        , a4 = Dict.remove entityId components.a4
                        , a5 = Dict.remove entityId components.a5
                        , a6 = Dict.remove entityId components.a6
                        , a7 = Dict.remove entityId components.a7
                        , a8 = Dict.remove entityId components.a8
                        }
            , size =
                \(Components8 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
                        + Dict.size components.a3
                        + Dict.size components.a4
                        + Dict.size components.a5
                        + Dict.size components.a6
                        + Dict.size components.a7
                        + Dict.size components.a8
            }
        )
        (Internal.ComponentSpec
            { get = \(Components8 components) -> components.a1
            , update =
                \updateFn (Components8 components) ->
                    Components8 (Record8.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components8 components) -> components.a2
            , update =
                \updateFn (Components8 components) ->
                    Components8 (Record8.update2 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components8 components) -> components.a3
            , update =
                \updateFn (Components8 components) ->
                    Components8 (Record8.update3 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components8 components) -> components.a4
            , update =
                \updateFn (Components8 components) ->
                    Components8 (Record8.update4 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components8 components) -> components.a5
            , update =
                \updateFn (Components8 components) ->
                    Components8 (Record8.update5 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components8 components) -> components.a6
            , update =
                \updateFn (Components8 components) ->
                    Components8 (Record8.update6 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components8 components) -> components.a7
            , update =
                \updateFn (Components8 components) ->
                    Components8 (Record8.update7 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components8 components) -> components.a8
            , update =
                \updateFn (Components8 components) ->
                    Components8 (Record8.update8 updateFn components)
            }
        )


{-| A components type for 9 components.
-}
type Components9 a1 a2 a3 a4 a5 a6 a7 a8 a9
    = Components9 (Record9.Record (Dict Int a1) (Dict Int a2) (Dict Int a3) (Dict Int a4) (Dict Int a5) (Dict Int a6) (Dict Int a7) (Dict Int a8) (Dict Int a9))


{-| Create all component specifications for 9 component types.
-}
specs9 :
    (AllComponentsSpec (Components9 a1 a2 a3 a4 a5 a6 a7 a8 a9)
     -> ComponentSpec (Components9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a1
     -> ComponentSpec (Components9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a2
     -> ComponentSpec (Components9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a3
     -> ComponentSpec (Components9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a4
     -> ComponentSpec (Components9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a5
     -> ComponentSpec (Components9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a6
     -> ComponentSpec (Components9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a7
     -> ComponentSpec (Components9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a8
     -> ComponentSpec (Components9 a1 a2 a3 a4 a5 a6 a7 a8 a9) a9
     -> specs
    )
    -> specs
specs9 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components9
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    , a4 = Dict.empty
                    , a5 = Dict.empty
                    , a6 = Dict.empty
                    , a7 = Dict.empty
                    , a8 = Dict.empty
                    , a9 = Dict.empty
                    }
            , clear =
                \entityId (Components9 components) ->
                    Components9
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        , a3 = Dict.remove entityId components.a3
                        , a4 = Dict.remove entityId components.a4
                        , a5 = Dict.remove entityId components.a5
                        , a6 = Dict.remove entityId components.a6
                        , a7 = Dict.remove entityId components.a7
                        , a8 = Dict.remove entityId components.a8
                        , a9 = Dict.remove entityId components.a9
                        }
            , size =
                \(Components9 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
                        + Dict.size components.a3
                        + Dict.size components.a4
                        + Dict.size components.a5
                        + Dict.size components.a6
                        + Dict.size components.a7
                        + Dict.size components.a8
                        + Dict.size components.a9
            }
        )
        (Internal.ComponentSpec
            { get = \(Components9 components) -> components.a1
            , update =
                \updateFn (Components9 components) ->
                    Components9 (Record9.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components9 components) -> components.a2
            , update =
                \updateFn (Components9 components) ->
                    Components9 (Record9.update2 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components9 components) -> components.a3
            , update =
                \updateFn (Components9 components) ->
                    Components9 (Record9.update3 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components9 components) -> components.a4
            , update =
                \updateFn (Components9 components) ->
                    Components9 (Record9.update4 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components9 components) -> components.a5
            , update =
                \updateFn (Components9 components) ->
                    Components9 (Record9.update5 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components9 components) -> components.a6
            , update =
                \updateFn (Components9 components) ->
                    Components9 (Record9.update6 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components9 components) -> components.a7
            , update =
                \updateFn (Components9 components) ->
                    Components9 (Record9.update7 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components9 components) -> components.a8
            , update =
                \updateFn (Components9 components) ->
                    Components9 (Record9.update8 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components9 components) -> components.a9
            , update =
                \updateFn (Components9 components) ->
                    Components9 (Record9.update9 updateFn components)
            }
        )


{-| A components type for 10 components.
-}
type Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    = Components10 (Record10.Record (Dict Int a1) (Dict Int a2) (Dict Int a3) (Dict Int a4) (Dict Int a5) (Dict Int a6) (Dict Int a7) (Dict Int a8) (Dict Int a9) (Dict Int a10))


{-| Create all component specifications for 10 component types.
-}
specs10 :
    (AllComponentsSpec (Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> ComponentSpec (Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a1
     -> ComponentSpec (Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a2
     -> ComponentSpec (Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a3
     -> ComponentSpec (Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a4
     -> ComponentSpec (Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a5
     -> ComponentSpec (Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a6
     -> ComponentSpec (Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a7
     -> ComponentSpec (Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a8
     -> ComponentSpec (Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a9
     -> ComponentSpec (Components10 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10) a10
     -> specs
    )
    -> specs
specs10 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components10
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    , a4 = Dict.empty
                    , a5 = Dict.empty
                    , a6 = Dict.empty
                    , a7 = Dict.empty
                    , a8 = Dict.empty
                    , a9 = Dict.empty
                    , a10 = Dict.empty
                    }
            , clear =
                \entityId (Components10 components) ->
                    Components10
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        , a3 = Dict.remove entityId components.a3
                        , a4 = Dict.remove entityId components.a4
                        , a5 = Dict.remove entityId components.a5
                        , a6 = Dict.remove entityId components.a6
                        , a7 = Dict.remove entityId components.a7
                        , a8 = Dict.remove entityId components.a8
                        , a9 = Dict.remove entityId components.a9
                        , a10 = Dict.remove entityId components.a10
                        }
            , size =
                \(Components10 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
                        + Dict.size components.a3
                        + Dict.size components.a4
                        + Dict.size components.a5
                        + Dict.size components.a6
                        + Dict.size components.a7
                        + Dict.size components.a8
                        + Dict.size components.a9
                        + Dict.size components.a10
            }
        )
        (Internal.ComponentSpec
            { get = \(Components10 components) -> components.a1
            , update =
                \updateFn (Components10 components) ->
                    Components10 (Record10.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components10 components) -> components.a2
            , update =
                \updateFn (Components10 components) ->
                    Components10 (Record10.update2 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components10 components) -> components.a3
            , update =
                \updateFn (Components10 components) ->
                    Components10 (Record10.update3 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components10 components) -> components.a4
            , update =
                \updateFn (Components10 components) ->
                    Components10 (Record10.update4 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components10 components) -> components.a5
            , update =
                \updateFn (Components10 components) ->
                    Components10 (Record10.update5 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components10 components) -> components.a6
            , update =
                \updateFn (Components10 components) ->
                    Components10 (Record10.update6 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components10 components) -> components.a7
            , update =
                \updateFn (Components10 components) ->
                    Components10 (Record10.update7 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components10 components) -> components.a8
            , update =
                \updateFn (Components10 components) ->
                    Components10 (Record10.update8 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components10 components) -> components.a9
            , update =
                \updateFn (Components10 components) ->
                    Components10 (Record10.update9 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components10 components) -> components.a10
            , update =
                \updateFn (Components10 components) ->
                    Components10 (Record10.update10 updateFn components)
            }
        )


{-| A components type for 11 components.
-}
type Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11
    = Components11 (Record11.Record (Dict Int a1) (Dict Int a2) (Dict Int a3) (Dict Int a4) (Dict Int a5) (Dict Int a6) (Dict Int a7) (Dict Int a8) (Dict Int a9) (Dict Int a10) (Dict Int a11))


{-| Create all component specifications for 11 component types.
-}
specs11 :
    (AllComponentsSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11)
     -> ComponentSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a1
     -> ComponentSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a2
     -> ComponentSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a3
     -> ComponentSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a4
     -> ComponentSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a5
     -> ComponentSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a6
     -> ComponentSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a7
     -> ComponentSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a8
     -> ComponentSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a9
     -> ComponentSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a10
     -> ComponentSpec (Components11 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11) a11
     -> specs
    )
    -> specs
specs11 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components11
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    , a4 = Dict.empty
                    , a5 = Dict.empty
                    , a6 = Dict.empty
                    , a7 = Dict.empty
                    , a8 = Dict.empty
                    , a9 = Dict.empty
                    , a10 = Dict.empty
                    , a11 = Dict.empty
                    }
            , clear =
                \entityId (Components11 components) ->
                    Components11
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        , a3 = Dict.remove entityId components.a3
                        , a4 = Dict.remove entityId components.a4
                        , a5 = Dict.remove entityId components.a5
                        , a6 = Dict.remove entityId components.a6
                        , a7 = Dict.remove entityId components.a7
                        , a8 = Dict.remove entityId components.a8
                        , a9 = Dict.remove entityId components.a9
                        , a10 = Dict.remove entityId components.a10
                        , a11 = Dict.remove entityId components.a11
                        }
            , size =
                \(Components11 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
                        + Dict.size components.a3
                        + Dict.size components.a4
                        + Dict.size components.a5
                        + Dict.size components.a6
                        + Dict.size components.a7
                        + Dict.size components.a8
                        + Dict.size components.a9
                        + Dict.size components.a10
                        + Dict.size components.a11
            }
        )
        (Internal.ComponentSpec
            { get = \(Components11 components) -> components.a1
            , update =
                \updateFn (Components11 components) ->
                    Components11 (Record11.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components11 components) -> components.a2
            , update =
                \updateFn (Components11 components) ->
                    Components11 (Record11.update2 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components11 components) -> components.a3
            , update =
                \updateFn (Components11 components) ->
                    Components11 (Record11.update3 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components11 components) -> components.a4
            , update =
                \updateFn (Components11 components) ->
                    Components11 (Record11.update4 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components11 components) -> components.a5
            , update =
                \updateFn (Components11 components) ->
                    Components11 (Record11.update5 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components11 components) -> components.a6
            , update =
                \updateFn (Components11 components) ->
                    Components11 (Record11.update6 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components11 components) -> components.a7
            , update =
                \updateFn (Components11 components) ->
                    Components11 (Record11.update7 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components11 components) -> components.a8
            , update =
                \updateFn (Components11 components) ->
                    Components11 (Record11.update8 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components11 components) -> components.a9
            , update =
                \updateFn (Components11 components) ->
                    Components11 (Record11.update9 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components11 components) -> components.a10
            , update =
                \updateFn (Components11 components) ->
                    Components11 (Record11.update10 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components11 components) -> components.a11
            , update =
                \updateFn (Components11 components) ->
                    Components11 (Record11.update11 updateFn components)
            }
        )


{-| A components type for 12 components.
-}
type Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12
    = Components12 (Record12.Record (Dict Int a1) (Dict Int a2) (Dict Int a3) (Dict Int a4) (Dict Int a5) (Dict Int a6) (Dict Int a7) (Dict Int a8) (Dict Int a9) (Dict Int a10) (Dict Int a11) (Dict Int a12))


{-| Create all component specifications for 12 component types.
-}
specs12 :
    (AllComponentsSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12)
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a1
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a2
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a3
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a4
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a5
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a6
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a7
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a8
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a9
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a10
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a11
     -> ComponentSpec (Components12 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12) a12
     -> specs
    )
    -> specs
specs12 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components12
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    , a4 = Dict.empty
                    , a5 = Dict.empty
                    , a6 = Dict.empty
                    , a7 = Dict.empty
                    , a8 = Dict.empty
                    , a9 = Dict.empty
                    , a10 = Dict.empty
                    , a11 = Dict.empty
                    , a12 = Dict.empty
                    }
            , clear =
                \entityId (Components12 components) ->
                    Components12
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        , a3 = Dict.remove entityId components.a3
                        , a4 = Dict.remove entityId components.a4
                        , a5 = Dict.remove entityId components.a5
                        , a6 = Dict.remove entityId components.a6
                        , a7 = Dict.remove entityId components.a7
                        , a8 = Dict.remove entityId components.a8
                        , a9 = Dict.remove entityId components.a9
                        , a10 = Dict.remove entityId components.a10
                        , a11 = Dict.remove entityId components.a11
                        , a12 = Dict.remove entityId components.a12
                        }
            , size =
                \(Components12 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
                        + Dict.size components.a3
                        + Dict.size components.a4
                        + Dict.size components.a5
                        + Dict.size components.a6
                        + Dict.size components.a7
                        + Dict.size components.a8
                        + Dict.size components.a9
                        + Dict.size components.a10
                        + Dict.size components.a11
                        + Dict.size components.a12
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a1
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a2
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update2 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a3
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update3 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a4
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update4 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a5
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update5 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a6
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update6 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a7
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update7 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a8
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update8 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a9
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update9 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a10
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update10 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a11
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update11 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components12 components) -> components.a12
            , update =
                \updateFn (Components12 components) ->
                    Components12 (Record12.update12 updateFn components)
            }
        )

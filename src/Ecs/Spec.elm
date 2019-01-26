module Ecs.Spec exposing
    ( Spec, ComponentSpec
    , Components1, spec1, componentSpecs1
    , Components2, spec2, componentSpecs2
    , Components3, spec3, componentSpecs3
    )

{-|

@docs Spec, ComponentSpec
@docs Components1, spec1, componentSpecs1
@docs Components2, spec2, componentSpecs2
@docs Components3, spec3, componentSpecs3

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
import Ecs.Internal.Record1 as Record1
import Ecs.Internal.Record2 as Record2
import Ecs.Internal.Record3 as Record3
import Set exposing (Set)


{-| The specification type.
-}
type alias Spec components =
    Internal.Spec components


{-| A component specification type.
-}
type alias ComponentSpec components a =
    Internal.ComponentSpec components a


{-| A components type for 1 component.
-}
type Components1 a1
    = Components1 (Record1.Record (Dict Int a1))


{-| A components specification for 1 component type.
-}
spec1 : Spec (Components1 a1)
spec1 =
    Internal.Spec
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


{-| Create component specifications for 1 component type.
-}
componentSpecs1 :
    (ComponentSpec (Components1 a1) a1
     -> componentSpecs
    )
    -> componentSpecs
componentSpecs1 fn =
    fn
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


{-| A components specification for 2 component types.
-}
spec2 : Spec (Components2 a1 a2)
spec2 =
    Internal.Spec
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


{-| Create component specifications for 2 component types.
-}
componentSpecs2 :
    (ComponentSpec (Components2 a1 a2) a1
     -> ComponentSpec (Components2 a1 a2) a2
     -> componentSpecs
    )
    -> componentSpecs
componentSpecs2 fn =
    fn
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


{-| A components specification for 3 component types.
-}
spec3 : Spec (Components3 a1 a2 a3)
spec3 =
    Internal.Spec
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


{-| Create component specifications for 3 component types.
-}
componentSpecs3 :
    (ComponentSpec (Components3 a1 a2 a3) a1
     -> ComponentSpec (Components3 a1 a2 a3) a2
     -> ComponentSpec (Components3 a1 a2 a3) a3
     -> componentSpecs
    )
    -> componentSpecs
componentSpecs3 fn =
    fn
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

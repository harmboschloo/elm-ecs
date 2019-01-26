module Ecs.Spec exposing
    ( Spec, ComponentSpec
    , Data1, spec1, components1
    , Data2, spec2, components2
    , Data3, spec3, components3
    )

{-|

@docs Spec, ComponentSpec
@docs Data1, spec1, components1
@docs Data2, spec2, components2
@docs Data3, spec3, components3

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
import Ecs.Internal.Record1 as Record1
import Ecs.Internal.Record2 as Record2
import Ecs.Internal.Record3 as Record3
import Set exposing (Set)


{-| The data specification type.
-}
type alias Spec data =
    Internal.Spec data


{-| A component specification type.
-}
type alias ComponentSpec data a =
    Internal.ComponentSpec data a


{-| An data type with 1 component type.
-}
type Data1 a1
    = Data1 (Record1.Record (Dict Int a1))


{-| An data specification with 1 component type.
-}
spec1 : Spec (Data1 a1)
spec1 =
    Internal.Spec
        { empty =
            Data1
                { a1 = Dict.empty
                }
        , clear =
            \entityId (Data1 data) ->
                Data1
                    { a1 = Dict.remove entityId data.a1
                    }
        , size =
            \(Data1 data) ->
                Dict.size data.a1
        }


{-| Create component specifications for an data with 1 component type.
-}
components1 :
    (ComponentSpec (Data1 a1) a1
     -> componentSpecs
    )
    -> componentSpecs
components1 fn =
    fn
        (Internal.ComponentSpec
            { get = \(Data1 data) -> data.a1
            , update =
                \updateFn (Data1 data) -> Data1 (Record1.update1 updateFn data)
            }
        )


{-| An data type with 2 component types.
-}
type Data2 a1 a2
    = Data2 (Record2.Record (Dict Int a1) (Dict Int a2))


{-| An data specification with 2 component types.
-}
spec2 : Spec (Data2 a1 a2)
spec2 =
    Internal.Spec
        { empty =
            Data2
                { a1 = Dict.empty
                , a2 = Dict.empty
                }
        , clear =
            \entityId (Data2 data) ->
                Data2
                    { a1 = Dict.remove entityId data.a1
                    , a2 = Dict.remove entityId data.a2
                    }
        , size =
            \(Data2 data) ->
                Dict.size data.a1
                    + Dict.size data.a2
        }


{-| Create component specifications for an data with 2 component types.
-}
components2 :
    (ComponentSpec (Data2 a1 a2) a1
     -> ComponentSpec (Data2 a1 a2) a2
     -> componentSpecs
    )
    -> componentSpecs
components2 fn =
    fn
        (Internal.ComponentSpec
            { get = \(Data2 data) -> data.a1
            , update =
                \updateFn (Data2 data) -> Data2 (Record2.update1 updateFn data)
            }
        )
        (Internal.ComponentSpec
            { get = \(Data2 data) -> data.a2
            , update =
                \updateFn (Data2 data) -> Data2 (Record2.update2 updateFn data)
            }
        )


{-| An data type with 3 component types.
-}
type Data3 a1 a2 a3
    = Data3 (Record3.Record (Dict Int a1) (Dict Int a2) (Dict Int a3))


{-| An data specification with 3 component types.
-}
spec3 : Spec (Data3 a1 a2 a3)
spec3 =
    Internal.Spec
        { empty =
            Data3
                { a1 = Dict.empty
                , a2 = Dict.empty
                , a3 = Dict.empty
                }
        , clear =
            \entityId (Data3 data) ->
                Data3
                    { a1 = Dict.remove entityId data.a1
                    , a2 = Dict.remove entityId data.a2
                    , a3 = Dict.remove entityId data.a3
                    }
        , size =
            \(Data3 data) ->
                Dict.size data.a1
                    + Dict.size data.a2
                    + Dict.size data.a3
        }


{-| Create component specifications for an data with 3 component types.
-}
components3 :
    (ComponentSpec (Data3 a1 a2 a3) a1
     -> ComponentSpec (Data3 a1 a2 a3) a2
     -> ComponentSpec (Data3 a1 a2 a3) a3
     -> componentSpecs
    )
    -> componentSpecs
components3 fn =
    fn
        (Internal.ComponentSpec
            { get = \(Data3 data) -> data.a1
            , update =
                \updateFn (Data3 data) -> Data3 (Record3.update1 updateFn data)
            }
        )
        (Internal.ComponentSpec
            { get = \(Data3 data) -> data.a2
            , update =
                \updateFn (Data3 data) -> Data3 (Record3.update2 updateFn data)
            }
        )
        (Internal.ComponentSpec
            { get = \(Data3 data) -> data.a3
            , update =
                \updateFn (Data3 data) -> Data3 (Record3.update3 updateFn data)
            }
        )

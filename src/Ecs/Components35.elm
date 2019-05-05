module Ecs.Components35 exposing (Components35, specs)

{-|

@docs Components35, specs

-}

import Dict exposing (Dict)
import Ecs.Internal
    exposing
        ( AllComponentsSpec(..)
        , ComponentSpec(..)
        )


{-| A container for 35 component types.
-}
type Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35
    = Components35
        { dict1 : Dict comparable a1
        , dict2 : Dict comparable a2
        , dict3 : Dict comparable a3
        , dict4 : Dict comparable a4
        , dict5 : Dict comparable a5
        , dict6 : Dict comparable a6
        , dict7 : Dict comparable a7
        , dict8 : Dict comparable a8
        , dict9 : Dict comparable a9
        , dict10 : Dict comparable a10
        , dict11 : Dict comparable a11
        , dict12 : Dict comparable a12
        , dict13 : Dict comparable a13
        , dict14 : Dict comparable a14
        , dict15 : Dict comparable a15
        , dict16 : Dict comparable a16
        , dict17 : Dict comparable a17
        , dict18 : Dict comparable a18
        , dict19 : Dict comparable a19
        , dict20 : Dict comparable a20
        , dict21 : Dict comparable a21
        , dict22 : Dict comparable a22
        , dict23 : Dict comparable a23
        , dict24 : Dict comparable a24
        , dict25 : Dict comparable a25
        , dict26 : Dict comparable a26
        , dict27 : Dict comparable a27
        , dict28 : Dict comparable a28
        , dict29 : Dict comparable a29
        , dict30 : Dict comparable a30
        , dict31 : Dict comparable a31
        , dict32 : Dict comparable a32
        , dict33 : Dict comparable a33
        , dict34 : Dict comparable a34
        , dict35 : Dict comparable a35
        }


{-| Create all component specifications for 35 component types.
-}
specs :
    (AllComponentsSpec comparable (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a1 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a2 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a3 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a4 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a5 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a6 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a7 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a8 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a9 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a10 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a11 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a12 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a13 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a14 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a15 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a16 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a17 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a18 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a19 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a20 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a21 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a22 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a23 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a24 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a25 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a26 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a27 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a28 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a29 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a30 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a31 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a32 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a33 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a34 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> ComponentSpec comparable a35 (Components35 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35)
     -> specs
    )
    -> specs
specs fn =
    fn
        (AllComponentsSpec
            { empty =
                Components35
                    { dict1 = Dict.empty
                    , dict2 = Dict.empty
                    , dict3 = Dict.empty
                    , dict4 = Dict.empty
                    , dict5 = Dict.empty
                    , dict6 = Dict.empty
                    , dict7 = Dict.empty
                    , dict8 = Dict.empty
                    , dict9 = Dict.empty
                    , dict10 = Dict.empty
                    , dict11 = Dict.empty
                    , dict12 = Dict.empty
                    , dict13 = Dict.empty
                    , dict14 = Dict.empty
                    , dict15 = Dict.empty
                    , dict16 = Dict.empty
                    , dict17 = Dict.empty
                    , dict18 = Dict.empty
                    , dict19 = Dict.empty
                    , dict20 = Dict.empty
                    , dict21 = Dict.empty
                    , dict22 = Dict.empty
                    , dict23 = Dict.empty
                    , dict24 = Dict.empty
                    , dict25 = Dict.empty
                    , dict26 = Dict.empty
                    , dict27 = Dict.empty
                    , dict28 = Dict.empty
                    , dict29 = Dict.empty
                    , dict30 = Dict.empty
                    , dict31 = Dict.empty
                    , dict32 = Dict.empty
                    , dict33 = Dict.empty
                    , dict34 = Dict.empty
                    , dict35 = Dict.empty
                    }
            , clear =
                \entityId (Components35 components) ->
                    Components35
                        { dict1 = Dict.remove entityId components.dict1
                        , dict2 = Dict.remove entityId components.dict2
                        , dict3 = Dict.remove entityId components.dict3
                        , dict4 = Dict.remove entityId components.dict4
                        , dict5 = Dict.remove entityId components.dict5
                        , dict6 = Dict.remove entityId components.dict6
                        , dict7 = Dict.remove entityId components.dict7
                        , dict8 = Dict.remove entityId components.dict8
                        , dict9 = Dict.remove entityId components.dict9
                        , dict10 = Dict.remove entityId components.dict10
                        , dict11 = Dict.remove entityId components.dict11
                        , dict12 = Dict.remove entityId components.dict12
                        , dict13 = Dict.remove entityId components.dict13
                        , dict14 = Dict.remove entityId components.dict14
                        , dict15 = Dict.remove entityId components.dict15
                        , dict16 = Dict.remove entityId components.dict16
                        , dict17 = Dict.remove entityId components.dict17
                        , dict18 = Dict.remove entityId components.dict18
                        , dict19 = Dict.remove entityId components.dict19
                        , dict20 = Dict.remove entityId components.dict20
                        , dict21 = Dict.remove entityId components.dict21
                        , dict22 = Dict.remove entityId components.dict22
                        , dict23 = Dict.remove entityId components.dict23
                        , dict24 = Dict.remove entityId components.dict24
                        , dict25 = Dict.remove entityId components.dict25
                        , dict26 = Dict.remove entityId components.dict26
                        , dict27 = Dict.remove entityId components.dict27
                        , dict28 = Dict.remove entityId components.dict28
                        , dict29 = Dict.remove entityId components.dict29
                        , dict30 = Dict.remove entityId components.dict30
                        , dict31 = Dict.remove entityId components.dict31
                        , dict32 = Dict.remove entityId components.dict32
                        , dict33 = Dict.remove entityId components.dict33
                        , dict34 = Dict.remove entityId components.dict34
                        , dict35 = Dict.remove entityId components.dict35
                        }
            , size =
                \(Components35 components) ->
                    Dict.size components.dict1
                        + Dict.size components.dict2
                        + Dict.size components.dict3
                        + Dict.size components.dict4
                        + Dict.size components.dict5
                        + Dict.size components.dict6
                        + Dict.size components.dict7
                        + Dict.size components.dict8
                        + Dict.size components.dict9
                        + Dict.size components.dict10
                        + Dict.size components.dict11
                        + Dict.size components.dict12
                        + Dict.size components.dict13
                        + Dict.size components.dict14
                        + Dict.size components.dict15
                        + Dict.size components.dict16
                        + Dict.size components.dict17
                        + Dict.size components.dict18
                        + Dict.size components.dict19
                        + Dict.size components.dict20
                        + Dict.size components.dict21
                        + Dict.size components.dict22
                        + Dict.size components.dict23
                        + Dict.size components.dict24
                        + Dict.size components.dict25
                        + Dict.size components.dict26
                        + Dict.size components.dict27
                        + Dict.size components.dict28
                        + Dict.size components.dict29
                        + Dict.size components.dict30
                        + Dict.size components.dict31
                        + Dict.size components.dict32
                        + Dict.size components.dict33
                        + Dict.size components.dict34
                        + Dict.size components.dict35
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict1
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = dict
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict2
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = dict
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict3
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = dict
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict4
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = dict
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict5
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = dict
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict6
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = dict
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict7
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = dict
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict8
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = dict
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict9
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = dict
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict10
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = dict
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict11
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = dict
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict12
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = dict
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict13
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = dict
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict14
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = dict
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict15
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = dict
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict16
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = dict
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict17
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = dict
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict18
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = dict
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict19
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = dict
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict20
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = dict
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict21
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = dict
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict22
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = dict
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict23
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = dict
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict24
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = dict
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict25
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = dict
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict26
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = dict
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict27
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = dict
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict28
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = dict
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict29
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = dict
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict30
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = dict
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict31
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = dict
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict32
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = dict
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict33
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = dict
                        , dict34 = components.dict34
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict34
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = dict
                        , dict35 = components.dict35
                        }
            }
        )
        (ComponentSpec
            { get = \(Components35 components) -> components.dict35
            , set =
                \dict (Components35 components) ->
                    Components35
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        , dict9 = components.dict9
                        , dict10 = components.dict10
                        , dict11 = components.dict11
                        , dict12 = components.dict12
                        , dict13 = components.dict13
                        , dict14 = components.dict14
                        , dict15 = components.dict15
                        , dict16 = components.dict16
                        , dict17 = components.dict17
                        , dict18 = components.dict18
                        , dict19 = components.dict19
                        , dict20 = components.dict20
                        , dict21 = components.dict21
                        , dict22 = components.dict22
                        , dict23 = components.dict23
                        , dict24 = components.dict24
                        , dict25 = components.dict25
                        , dict26 = components.dict26
                        , dict27 = components.dict27
                        , dict28 = components.dict28
                        , dict29 = components.dict29
                        , dict30 = components.dict30
                        , dict31 = components.dict31
                        , dict32 = components.dict32
                        , dict33 = components.dict33
                        , dict34 = components.dict34
                        , dict35 = dict
                        }
            }
        )

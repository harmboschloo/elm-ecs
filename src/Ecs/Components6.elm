module Ecs.Components6 exposing (Components6, specs)

{-|

@docs Components6, specs

-}

import Dict exposing (Dict)
import Ecs.Internal
    exposing
        ( AllComponentsSpec(..)
        , ComponentSpec(..)
        )


{-| A container for 6 component types.
-}
type Components6 comparable a1 a2 a3 a4 a5 a6
    = Components6
        { dict1 : Dict comparable a1
        , dict2 : Dict comparable a2
        , dict3 : Dict comparable a3
        , dict4 : Dict comparable a4
        , dict5 : Dict comparable a5
        , dict6 : Dict comparable a6
        }


{-| Create all component specifications for 6 component types.
-}
specs :
    (AllComponentsSpec comparable (Components6 comparable a1 a2 a3 a4 a5 a6)
     -> ComponentSpec comparable a1 (Components6 comparable a1 a2 a3 a4 a5 a6)
     -> ComponentSpec comparable a2 (Components6 comparable a1 a2 a3 a4 a5 a6)
     -> ComponentSpec comparable a3 (Components6 comparable a1 a2 a3 a4 a5 a6)
     -> ComponentSpec comparable a4 (Components6 comparable a1 a2 a3 a4 a5 a6)
     -> ComponentSpec comparable a5 (Components6 comparable a1 a2 a3 a4 a5 a6)
     -> ComponentSpec comparable a6 (Components6 comparable a1 a2 a3 a4 a5 a6)
     -> specs
    )
    -> specs
specs fn =
    fn
        (AllComponentsSpec
            { empty =
                Components6
                    { dict1 = Dict.empty
                    , dict2 = Dict.empty
                    , dict3 = Dict.empty
                    , dict4 = Dict.empty
                    , dict5 = Dict.empty
                    , dict6 = Dict.empty
                    }
            , clear =
                \entityId (Components6 components) ->
                    Components6
                        { dict1 = Dict.remove entityId components.dict1
                        , dict2 = Dict.remove entityId components.dict2
                        , dict3 = Dict.remove entityId components.dict3
                        , dict4 = Dict.remove entityId components.dict4
                        , dict5 = Dict.remove entityId components.dict5
                        , dict6 = Dict.remove entityId components.dict6
                        }
            , size =
                \(Components6 components) ->
                    Dict.size components.dict1
                        + Dict.size components.dict2
                        + Dict.size components.dict3
                        + Dict.size components.dict4
                        + Dict.size components.dict5
                        + Dict.size components.dict6
            }
        )
        (ComponentSpec
            { get = \(Components6 components) -> components.dict1
            , set =
                \dict (Components6 components) ->
                    Components6
                        { dict1 = dict
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        }
            }
        )
        (ComponentSpec
            { get = \(Components6 components) -> components.dict2
            , set =
                \dict (Components6 components) ->
                    Components6
                        { dict1 = components.dict1
                        , dict2 = dict
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        }
            }
        )
        (ComponentSpec
            { get = \(Components6 components) -> components.dict3
            , set =
                \dict (Components6 components) ->
                    Components6
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = dict
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        }
            }
        )
        (ComponentSpec
            { get = \(Components6 components) -> components.dict4
            , set =
                \dict (Components6 components) ->
                    Components6
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = dict
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        }
            }
        )
        (ComponentSpec
            { get = \(Components6 components) -> components.dict5
            , set =
                \dict (Components6 components) ->
                    Components6
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = dict
                        , dict6 = components.dict6
                        }
            }
        )
        (ComponentSpec
            { get = \(Components6 components) -> components.dict6
            , set =
                \dict (Components6 components) ->
                    Components6
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = dict
                        }
            }
        )

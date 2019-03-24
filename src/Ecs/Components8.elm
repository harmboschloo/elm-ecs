module Ecs.Components8 exposing (Components8, specs)

{-|

@docs Components8, specs

-}

import Dict exposing (Dict)
import Ecs.Internal
    exposing
        ( AllComponentsSpec(..)
        , ComponentSpec(..)
        )


{-| A components type for 8 components.
-}
type Components8 comparable a1 a2 a3 a4 a5 a6 a7 a8
    = Components8
        { dict1 : Dict comparable a1
        , dict2 : Dict comparable a2
        , dict3 : Dict comparable a3
        , dict4 : Dict comparable a4
        , dict5 : Dict comparable a5
        , dict6 : Dict comparable a6
        , dict7 : Dict comparable a7
        , dict8 : Dict comparable a8
        }


{-| Create all component specifications for 8 component types.
-}
specs :
    (AllComponentsSpec comparable (Components8 comparable a1 a2 a3 a4 a5 a6 a7 a8)
     -> ComponentSpec comparable a1 (Components8 comparable a1 a2 a3 a4 a5 a6 a7 a8)
     -> ComponentSpec comparable a2 (Components8 comparable a1 a2 a3 a4 a5 a6 a7 a8)
     -> ComponentSpec comparable a3 (Components8 comparable a1 a2 a3 a4 a5 a6 a7 a8)
     -> ComponentSpec comparable a4 (Components8 comparable a1 a2 a3 a4 a5 a6 a7 a8)
     -> ComponentSpec comparable a5 (Components8 comparable a1 a2 a3 a4 a5 a6 a7 a8)
     -> ComponentSpec comparable a6 (Components8 comparable a1 a2 a3 a4 a5 a6 a7 a8)
     -> ComponentSpec comparable a7 (Components8 comparable a1 a2 a3 a4 a5 a6 a7 a8)
     -> ComponentSpec comparable a8 (Components8 comparable a1 a2 a3 a4 a5 a6 a7 a8)
     -> specs
    )
    -> specs
specs fn =
    fn
        (AllComponentsSpec
            { empty =
                Components8
                    { dict1 = Dict.empty
                    , dict2 = Dict.empty
                    , dict3 = Dict.empty
                    , dict4 = Dict.empty
                    , dict5 = Dict.empty
                    , dict6 = Dict.empty
                    , dict7 = Dict.empty
                    , dict8 = Dict.empty
                    }
            , clear =
                \entityId (Components8 components) ->
                    Components8
                        { dict1 = Dict.remove entityId components.dict1
                        , dict2 = Dict.remove entityId components.dict2
                        , dict3 = Dict.remove entityId components.dict3
                        , dict4 = Dict.remove entityId components.dict4
                        , dict5 = Dict.remove entityId components.dict5
                        , dict6 = Dict.remove entityId components.dict6
                        , dict7 = Dict.remove entityId components.dict7
                        , dict8 = Dict.remove entityId components.dict8
                        }
            , size =
                \(Components8 components) ->
                    Dict.size components.dict1
                        + Dict.size components.dict2
                        + Dict.size components.dict3
                        + Dict.size components.dict4
                        + Dict.size components.dict5
                        + Dict.size components.dict6
                        + Dict.size components.dict7
                        + Dict.size components.dict8
            }
        )
        (ComponentSpec
            { get = \(Components8 components) -> components.dict1
            , set =
                \dict (Components8 components) ->
                    Components8
                        { dict1 = dict
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        }
            }
        )
        (ComponentSpec
            { get = \(Components8 components) -> components.dict2
            , set =
                \dict (Components8 components) ->
                    Components8
                        { dict1 = components.dict1
                        , dict2 = dict
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        }
            }
        )
        (ComponentSpec
            { get = \(Components8 components) -> components.dict3
            , set =
                \dict (Components8 components) ->
                    Components8
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = dict
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        }
            }
        )
        (ComponentSpec
            { get = \(Components8 components) -> components.dict4
            , set =
                \dict (Components8 components) ->
                    Components8
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = dict
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        }
            }
        )
        (ComponentSpec
            { get = \(Components8 components) -> components.dict5
            , set =
                \dict (Components8 components) ->
                    Components8
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = dict
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        }
            }
        )
        (ComponentSpec
            { get = \(Components8 components) -> components.dict6
            , set =
                \dict (Components8 components) ->
                    Components8
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = dict
                        , dict7 = components.dict7
                        , dict8 = components.dict8
                        }
            }
        )
        (ComponentSpec
            { get = \(Components8 components) -> components.dict7
            , set =
                \dict (Components8 components) ->
                    Components8
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = dict
                        , dict8 = components.dict8
                        }
            }
        )
        (ComponentSpec
            { get = \(Components8 components) -> components.dict8
            , set =
                \dict (Components8 components) ->
                    Components8
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        , dict6 = components.dict6
                        , dict7 = components.dict7
                        , dict8 = dict
                        }
            }
        )

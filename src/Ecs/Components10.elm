module Ecs.Components10 exposing (Components10, specs)

{-|

@docs Components10, specs

-}

import Dict exposing (Dict)
import Ecs.Internal
    exposing
        ( AllComponentsSpec(..)
        , ComponentSpec(..)
        )


{-| A container for 10 component types.
-}
type Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    = Components10
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
        }


{-| Create all component specifications for 10 component types.
-}
specs :
    (AllComponentsSpec comparable (Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> ComponentSpec comparable a1 (Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> ComponentSpec comparable a2 (Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> ComponentSpec comparable a3 (Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> ComponentSpec comparable a4 (Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> ComponentSpec comparable a5 (Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> ComponentSpec comparable a6 (Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> ComponentSpec comparable a7 (Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> ComponentSpec comparable a8 (Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> ComponentSpec comparable a9 (Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> ComponentSpec comparable a10 (Components10 comparable a1 a2 a3 a4 a5 a6 a7 a8 a9 a10)
     -> specs
    )
    -> specs
specs fn =
    fn
        (AllComponentsSpec
            { empty =
                Components10
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
                    }
            , clear =
                \entityId (Components10 components) ->
                    Components10
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
                        }
            , size =
                \(Components10 components) ->
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
            }
        )
        (ComponentSpec
            { get = \(Components10 components) -> components.dict1
            , set =
                \dict (Components10 components) ->
                    Components10
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
                        }
            }
        )
        (ComponentSpec
            { get = \(Components10 components) -> components.dict2
            , set =
                \dict (Components10 components) ->
                    Components10
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
                        }
            }
        )
        (ComponentSpec
            { get = \(Components10 components) -> components.dict3
            , set =
                \dict (Components10 components) ->
                    Components10
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
                        }
            }
        )
        (ComponentSpec
            { get = \(Components10 components) -> components.dict4
            , set =
                \dict (Components10 components) ->
                    Components10
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
                        }
            }
        )
        (ComponentSpec
            { get = \(Components10 components) -> components.dict5
            , set =
                \dict (Components10 components) ->
                    Components10
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
                        }
            }
        )
        (ComponentSpec
            { get = \(Components10 components) -> components.dict6
            , set =
                \dict (Components10 components) ->
                    Components10
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
                        }
            }
        )
        (ComponentSpec
            { get = \(Components10 components) -> components.dict7
            , set =
                \dict (Components10 components) ->
                    Components10
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
                        }
            }
        )
        (ComponentSpec
            { get = \(Components10 components) -> components.dict8
            , set =
                \dict (Components10 components) ->
                    Components10
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
                        }
            }
        )
        (ComponentSpec
            { get = \(Components10 components) -> components.dict9
            , set =
                \dict (Components10 components) ->
                    Components10
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
                        }
            }
        )
        (ComponentSpec
            { get = \(Components10 components) -> components.dict10
            , set =
                \dict (Components10 components) ->
                    Components10
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
                        }
            }
        )

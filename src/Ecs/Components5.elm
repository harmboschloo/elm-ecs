module Ecs.Components5 exposing (Components5, specs)

{-|

@docs Components5, specs

-}

import Dict exposing (Dict)
import Ecs.Internal
    exposing
        ( ComponentSpec(..)
        , MultiComponentSpec(..)
        )


{-| A components type for 5 components.
-}
type Components5 comparable a1 a2 a3 a4 a5
    = Components5
        { dict1 : Dict comparable a1
        , dict2 : Dict comparable a2
        , dict3 : Dict comparable a3
        , dict4 : Dict comparable a4
        , dict5 : Dict comparable a5
        }


{-| Create all component specifications for 5 component types.
-}
specs :
    (MultiComponentSpec comparable (Components5 comparable a1 a2 a3 a4 a5)
     -> ComponentSpec comparable a1 (Components5 comparable a1 a2 a3 a4 a5)
     -> ComponentSpec comparable a2 (Components5 comparable a1 a2 a3 a4 a5)
     -> ComponentSpec comparable a3 (Components5 comparable a1 a2 a3 a4 a5)
     -> ComponentSpec comparable a4 (Components5 comparable a1 a2 a3 a4 a5)
     -> ComponentSpec comparable a5 (Components5 comparable a1 a2 a3 a4 a5)
     -> specs
    )
    -> specs
specs fn =
    fn
        (MultiComponentSpec
            { empty =
                Components5
                    { dict1 = Dict.empty
                    , dict2 = Dict.empty
                    , dict3 = Dict.empty
                    , dict4 = Dict.empty
                    , dict5 = Dict.empty
                    }
            , clear =
                \entityId (Components5 components) ->
                    Components5
                        { dict1 = Dict.remove entityId components.dict1
                        , dict2 = Dict.remove entityId components.dict2
                        , dict3 = Dict.remove entityId components.dict3
                        , dict4 = Dict.remove entityId components.dict4
                        , dict5 = Dict.remove entityId components.dict5
                        }
            , size =
                \(Components5 components) ->
                    Dict.size components.dict1
                        + Dict.size components.dict2
                        + Dict.size components.dict3
                        + Dict.size components.dict4
                        + Dict.size components.dict5
            }
        )
        (ComponentSpec
            { get = \(Components5 components) -> components.dict1
            , set =
                \dict (Components5 components) ->
                    Components5
                        { dict1 = dict
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        }
            }
        )
        (ComponentSpec
            { get = \(Components5 components) -> components.dict2
            , set =
                \dict (Components5 components) ->
                    Components5
                        { dict1 = components.dict1
                        , dict2 = dict
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        }
            }
        )
        (ComponentSpec
            { get = \(Components5 components) -> components.dict3
            , set =
                \dict (Components5 components) ->
                    Components5
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = dict
                        , dict4 = components.dict4
                        , dict5 = components.dict5
                        }
            }
        )
        (ComponentSpec
            { get = \(Components5 components) -> components.dict4
            , set =
                \dict (Components5 components) ->
                    Components5
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = dict
                        , dict5 = components.dict5
                        }
            }
        )
        (ComponentSpec
            { get = \(Components5 components) -> components.dict5
            , set =
                \dict (Components5 components) ->
                    Components5
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        , dict5 = dict
                        }
            }
        )

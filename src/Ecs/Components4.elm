module Ecs.Components4 exposing (Components4, specs)

{-|

@docs Components4, specs

-}

import Dict exposing (Dict)
import Ecs.Internal
    exposing
        ( ComponentSpec(..)
        , MultiComponentSpec(..)
        )


{-| A components type for 4 components.
-}
type Components4 comparable a1 a2 a3 a4
    = Components4
        { dict1 : Dict comparable a1
        , dict2 : Dict comparable a2
        , dict3 : Dict comparable a3
        , dict4 : Dict comparable a4
        }


{-| Create all component specifications for 4 component types.
-}
specs :
    (MultiComponentSpec comparable (Components4 comparable a1 a2 a3 a4)
     -> ComponentSpec comparable a1 (Components4 comparable a1 a2 a3 a4)
     -> ComponentSpec comparable a2 (Components4 comparable a1 a2 a3 a4)
     -> ComponentSpec comparable a3 (Components4 comparable a1 a2 a3 a4)
     -> ComponentSpec comparable a4 (Components4 comparable a1 a2 a3 a4)
     -> specs
    )
    -> specs
specs fn =
    fn
        (MultiComponentSpec
            { empty =
                Components4
                    { dict1 = Dict.empty
                    , dict2 = Dict.empty
                    , dict3 = Dict.empty
                    , dict4 = Dict.empty
                    }
            , clear =
                \entityId (Components4 components) ->
                    Components4
                        { dict1 = Dict.remove entityId components.dict1
                        , dict2 = Dict.remove entityId components.dict2
                        , dict3 = Dict.remove entityId components.dict3
                        , dict4 = Dict.remove entityId components.dict4
                        }
            , size =
                \(Components4 components) ->
                    Dict.size components.dict1
                        + Dict.size components.dict2
                        + Dict.size components.dict3
                        + Dict.size components.dict4
            }
        )
        (ComponentSpec
            { get = \(Components4 components) -> components.dict1
            , set =
                \dict (Components4 components) ->
                    Components4
                        { dict1 = dict
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        }
            }
        )
        (ComponentSpec
            { get = \(Components4 components) -> components.dict2
            , set =
                \dict (Components4 components) ->
                    Components4
                        { dict1 = components.dict1
                        , dict2 = dict
                        , dict3 = components.dict3
                        , dict4 = components.dict4
                        }
            }
        )
        (ComponentSpec
            { get = \(Components4 components) -> components.dict3
            , set =
                \dict (Components4 components) ->
                    Components4
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = dict
                        , dict4 = components.dict4
                        }
            }
        )
        (ComponentSpec
            { get = \(Components4 components) -> components.dict4
            , set =
                \dict (Components4 components) ->
                    Components4
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        , dict4 = dict
                        }
            }
        )

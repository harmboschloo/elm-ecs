module V2e_EntityOperation.Ecs.Components3 exposing (Components3, specs)

{-|

@docs Components3, specs

-}

import Dict exposing (Dict)
import V2e_EntityOperation.Ecs.Internal
    exposing
        ( ComponentSpec(..)
        , MultiComponentSpec(..)
        )


{-| A components type for 3 components.
-}
type Components3 comparable a1 a2 a3
    = Components3
        { dict1 : Dict comparable a1
        , dict2 : Dict comparable a2
        , dict3 : Dict comparable a3
        }


{-| Create all component specifications for 3 component types.
-}
specs :
    (MultiComponentSpec comparable (Components3 comparable a1 a2 a3)
     -> ComponentSpec comparable a1 (Components3 comparable a1 a2 a3)
     -> ComponentSpec comparable a2 (Components3 comparable a1 a2 a3)
     -> ComponentSpec comparable a3 (Components3 comparable a1 a2 a3)
     -> specs
    )
    -> specs
specs fn =
    fn
        (MultiComponentSpec
            { empty =
                Components3
                    { dict1 = Dict.empty
                    , dict2 = Dict.empty
                    , dict3 = Dict.empty
                    }
            , clear =
                \entityId (Components3 components) ->
                    Components3
                        { dict1 = Dict.remove entityId components.dict1
                        , dict2 = Dict.remove entityId components.dict2
                        , dict3 = Dict.remove entityId components.dict3
                        }
            , size =
                \(Components3 components) ->
                    Dict.size components.dict1
                        + Dict.size components.dict2
                        + Dict.size components.dict3
            }
        )
        (ComponentSpec
            { get = \(Components3 components) -> components.dict1
            , set =
                \dict (Components3 components) ->
                    Components3
                        { dict1 = dict
                        , dict2 = components.dict2
                        , dict3 = components.dict3
                        }
            }
        )
        (ComponentSpec
            { get = \(Components3 components) -> components.dict2
            , set =
                \dict (Components3 components) ->
                    Components3
                        { dict1 = components.dict1
                        , dict2 = dict
                        , dict3 = components.dict3
                        }
            }
        )
        (ComponentSpec
            { get = \(Components3 components) -> components.dict3
            , set =
                \dict (Components3 components) ->
                    Components3
                        { dict1 = components.dict1
                        , dict2 = components.dict2
                        , dict3 = dict
                        }
            }
        )

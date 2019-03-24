module Ecs.Components2 exposing (Components2, specs)

{-|

@docs Components2, specs

-}

import Dict exposing (Dict)
import Ecs.Internal
    exposing
        ( AllComponentsSpec(..)
        , ComponentSpec(..)
        )


{-| A components type for 2 components.
-}
type Components2 comparable a1 a2
    = Components2
        { dict1 : Dict comparable a1
        , dict2 : Dict comparable a2
        }


{-| Create all component specifications for 2 component types.
-}
specs :
    (AllComponentsSpec comparable (Components2 comparable a1 a2)
     -> ComponentSpec comparable a1 (Components2 comparable a1 a2)
     -> ComponentSpec comparable a2 (Components2 comparable a1 a2)
     -> specs
    )
    -> specs
specs fn =
    fn
        (AllComponentsSpec
            { empty =
                Components2
                    { dict1 = Dict.empty
                    , dict2 = Dict.empty
                    }
            , clear =
                \entityId (Components2 components) ->
                    Components2
                        { dict1 = Dict.remove entityId components.dict1
                        , dict2 = Dict.remove entityId components.dict2
                        }
            , size =
                \(Components2 components) ->
                    Dict.size components.dict1
                        + Dict.size components.dict2
            }
        )
        (ComponentSpec
            { get = \(Components2 components) -> components.dict1
            , set =
                \dict (Components2 components) ->
                    Components2
                        { dict1 = dict
                        , dict2 = components.dict2
                        }
            }
        )
        (ComponentSpec
            { get = \(Components2 components) -> components.dict2
            , set =
                \dict (Components2 components) ->
                    Components2
                        { dict1 = components.dict1
                        , dict2 = dict
                        }
            }
        )

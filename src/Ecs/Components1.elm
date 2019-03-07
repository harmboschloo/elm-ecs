module Ecs.Components1 exposing (Components1, specs)

{-|

@docs Components1, specs

-}

import Dict exposing (Dict)
import Ecs.Internal
    exposing
        ( ComponentSpec(..)
        , MultiComponentSpec(..)
        )


{-| A components type for 1 component.
-}
type Components1 comparable a1
    = Components1
        { dict1 : Dict comparable a1
        }


{-| Create all component specifications for 1 component type.
-}
specs :
    (MultiComponentSpec comparable (Components1 comparable a1)
     -> ComponentSpec comparable a1 (Components1 comparable a1)
     -> specs
    )
    -> specs
specs fn =
    fn
        (MultiComponentSpec
            { empty =
                Components1
                    { dict1 = Dict.empty
                    }
            , clear =
                \entityId (Components1 components) ->
                    Components1
                        { dict1 = Dict.remove entityId components.dict1
                        }
            , size =
                \(Components1 components) ->
                    Dict.size components.dict1
            }
        )
        (ComponentSpec
            { get = \(Components1 components) -> components.dict1
            , set =
                \dict (Components1 components) ->
                    Components1
                        { dict1 = dict
                        }
            }
        )

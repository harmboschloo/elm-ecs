// @ts-check
const { range } = require("./utils");

exports.generate = function(n) {
  const components = range(n);

  const componentsType = `Components${n} comparable ${components
    .map(i => `a${i}`)
    .join(" ")}`;

  return `module Ecs.Components${n} exposing (Components${n}, specs)

{-|

@docs Components${n}, specs

-}

import Dict exposing (Dict)
import Ecs.Internal
    exposing
        ( AllComponentSpec(..)
        , ComponentSpec(..)
        )


{-| A components type for ${n} component${n > 1 ? "s" : ""}.
-}
type ${componentsType}
    = Components${n}
        { ${components.map(i => `dict${i} : Dict comparable a${i}`).join(`
        , `)}
        }


{-| Create all component specifications for ${n} component type${
    n > 1 ? "s" : ""
  }.
-}
specs :
    (AllComponentSpec comparable (${componentsType})
     -> ${components.map(
       i => `ComponentSpec comparable a${i} (${componentsType})`
     ).join(`
     -> `)}
     -> specs
    )
    -> specs
specs fn =
    fn
        (AllComponentSpec
            { empty =
                Components${n}
                    { ${components.map(i => `dict${i} = Dict.empty`).join(`
                    , `)}
                    }
            , clear =
                \\entityId (Components${n} components) ->
                    Components${n}
                        { ${components.map(
                          i =>
                            `dict${i} = Dict.remove entityId components.dict${i}`
                        ).join(`
                        , `)}
                        }
            , size =
                \\(Components${n} components) ->
                    ${components.map(i => `Dict.size components.dict${i}`)
                      .join(`
                        + `)}
            }
        )
        ${components.map(
          i => `(ComponentSpec
            { get = \\(Components${n} components) -> components.dict${i}
            , set =
                \\dict (Components${n} components) ->
                    Components${n}
                        { ${components.map(
                          f =>
                            `dict${f} = ${
                              f === i ? `dict` : `components.dict${f}`
                            }`
                        ).join(`
                        , `)}
                        }
            }
        )`
        ).join(`
        `)}
`;
};

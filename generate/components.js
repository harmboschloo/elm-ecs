// @ts-check
const { range } = require("./utils");

exports.generate = function(n) {
  const specs = range(n);

  return `module Ecs.Components exposing
    ( AllComponentsSpec, ComponentSpec
    , ${specs.map(i => `Components${i}, specs${i}`).join(`
    , `)}
    )

{-|

@docs AllComponentsSpec, ComponentSpec
${specs.map(i => `@docs Components${i}, specs${i}`).join(`
`)}

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
${specs.map(i => `import Ecs.Internal.Record${i} as Record${i}`).join(`
`)}


{-| The specification type for all components.
-}
type alias AllComponentsSpec components =
    Internal.AllComponentsSpec components


{-| A specification type for a component.
-}
type alias ComponentSpec components a =
    Internal.ComponentSpec components a
${specs.map(generateComponentSpecs).join(`
`)}
`;
};

const generateComponentSpecs = iSpec => {
  const components = range(iSpec);

  const componentsType = `Components${iSpec} ${components
    .map(i => `a${i}`)
    .join(" ")}`;
  const recordType = `Record${iSpec}.Record ${components
    .map(i => `(Dict Int a${i})`)
    .join(" ")}`;

  return `

{-| A components type for ${iSpec} component${iSpec > 1 ? "s" : ""}.
-}
type ${componentsType}
    = Components${iSpec} (${recordType})


{-| Create all component specifications for ${iSpec} component type${
    iSpec > 1 ? "s" : ""
  }.
-}
specs${iSpec} :
    (AllComponentsSpec (${componentsType})
     -> ${components.map(i => `ComponentSpec (${componentsType}) a${i}`).join(`
     -> `)}
     -> specs
    )
    -> specs
specs${iSpec} fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components${iSpec}
                    { ${components.map(i => `a${i} = Dict.empty`).join(`
                    , `)}
                    }
            , clear =
                \\entityId (Components${iSpec} components) ->
                    Components${iSpec}
                        { ${components.map(
                          i => `a${i} = Dict.remove entityId components.a${i}`
                        ).join(`
                        , `)}
                        }
            , size =
                \\(Components${iSpec} components) ->
                    ${components.map(i => `Dict.size components.a${i}`).join(`
                        + `)}
            }
        )
        ${components.map(
          iComponent => `(Internal.ComponentSpec
            { get = \\(Components${iSpec} components) -> components.a${iComponent}
            , update =
                \\updateFn (Components${iSpec} components) ->
                    Components${iSpec} (Record${iSpec}.update${iComponent} updateFn components)
            }
        )`
        ).join(`
        `)}`;
};

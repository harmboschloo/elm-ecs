// @ts-check
const { range } = require("./utils");

exports.generate = function(n) {
  const specs = range(n);

  return `module Ecs.Spec exposing
    ( Spec, ComponentSpec
    , ${specs.map(i => `Components${i}, spec${i}, componentSpecs${i}`).join(`
    , `)}
    )

{-|

@docs Spec, ComponentSpec
${specs.map(i => `@docs Components${i}, spec${i}, componentSpecs${i}`).join(`
`)}

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
${specs.map(i => `import Ecs.Internal.Record${i} as Record${i}`).join(`
`)}
import Set exposing (Set)


{-| The specification type.
-}
type alias Spec components =
    Internal.Spec components


{-| A component specification type.
-}
type alias ComponentSpec components a =
    Internal.ComponentSpec components a
${specs.map(iSpec => {
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


{-| A components specification for ${iSpec} component type${
      iSpec > 1 ? "s" : ""
    }.
-}
spec${iSpec} : Spec (${componentsType})
spec${iSpec} =
    Internal.Spec
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


{-| Create component specifications for ${iSpec} component type${
      iSpec > 1 ? "s" : ""
    }.
-}
componentSpecs${iSpec} :
    (${components.map(i => `ComponentSpec (${componentsType}) a${i}`).join(`
     -> `)}
     -> componentSpecs
    )
    -> componentSpecs
componentSpecs${iSpec} fn =
    fn
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
  }).join(`
`)}
`;
};

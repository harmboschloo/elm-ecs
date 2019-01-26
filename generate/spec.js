// @ts-check
const { range } = require("./utils");

exports.generate = function(n) {
  const specs = range(n);

  return `module Ecs.Spec exposing
    ( Spec, ComponentSpec
    , ${specs.map(i => `Data${i}, spec${i}, components${i}`).join(`
    , `)}
    )

{-|

@docs Spec, ComponentSpec
${specs.map(i => `@docs Data${i}, spec${i}, components${i}`).join(`
`)}

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
${specs.map(i => `import Ecs.Internal.Record${i} as Record${i}`).join(`
`)}
import Set exposing (Set)


{-| The data specification type.
-}
type alias Spec data =
    Internal.Spec data


{-| A component specification type.
-}
type alias ComponentSpec data a =
    Internal.ComponentSpec data a
${specs.map(iSpec => {
    const components = range(iSpec);

    const dataType = `Data${iSpec} ${components.map(i => `a${i}`).join(" ")}`;
    const recordType = `Record${iSpec}.Record ${components
      .map(i => `(Dict Int a${i})`)
      .join(" ")}`;

    return `

{-| An data type with ${iSpec} component type${iSpec > 1 ? "s" : ""}.
-}
type ${dataType}
    = Data${iSpec} (${recordType})


{-| An data specification with ${iSpec} component type${iSpec > 1 ? "s" : ""}.
-}
spec${iSpec} : Spec (${dataType})
spec${iSpec} =
    Internal.Spec
        { empty =
            Data${iSpec}
                { ${components.map(i => `a${i} = Dict.empty`).join(`
                , `)}
                }
        , clear =
            \\entityId (Data${iSpec} data) ->
                Data${iSpec}
                    { ${components.map(
                      i => `a${i} = Dict.remove entityId data.a${i}`
                    ).join(`
                    , `)}
                    }
        , size =
            \\(Data${iSpec} data) ->
                ${components.map(i => `Dict.size data.a${i}`).join(`
                    + `)}
        }


{-| Create component specifications for an data with ${iSpec} component type${
      iSpec > 1 ? "s" : ""
    }.
-}
components${iSpec} :
    (${components.map(i => `ComponentSpec (${dataType}) a${i}`).join(`
     -> `)}
     -> componentSpecs
    )
    -> componentSpecs
components${iSpec} fn =
    fn
        ${components.map(
          iComponent => `(Internal.ComponentSpec
            { get = \\(Data${iSpec} data) -> data.a${iComponent}
            , update =
                \\updateFn (Data${iSpec} data) -> Data${iSpec} (Record${iSpec}.update${iComponent} updateFn data)
            }
        )`
        ).join(`
        `)}`;
  }).join(`
`)}
`;
};

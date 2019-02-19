// @ts-check
const { range } = require("./utils");

exports.generate = function(n) {
  const specs = range(n);

  return `module Ecs.Singletons exposing
    ( SingletonSpec
    , ${specs.map(i => `Singletons${i}, init${i}, specs${i}`).join(`
    , `)}
    )

{-|

@docs SingletonSpec
${specs.map(i => `@docs Singletons${i}, init${i}, specs${i}`).join(`
`)}

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
${specs.map(i => `import Ecs.Internal.Record${i} as Record${i}`).join(`
`)}


{-| A specification type for a singleton.
-}
type alias SingletonSpec singletons a =
    Internal.SingletonSpec singletons a
${specs.map(generateSingletonSpecs).join(`
`)}
`;
};

const generateSingletonSpecs = iSpec => {
  const singletons = range(iSpec);

  const singletonsType = `Singletons${iSpec} ${singletons
    .map(i => `a${i}`)
    .join(" ")}`;
  const recordType = `Record${iSpec}.Record ${singletons
    .map(i => `a${i}`)
    .join(" ")}`;

  return `

{-| A singletons type for ${iSpec} singleton${iSpec > 1 ? "s" : ""}.
-}
type ${singletonsType}
    = Singletons${iSpec} (${recordType})


{-| Initialize a singleton type for ${iSpec} singleton${iSpec > 1 ? "s" : ""}.
-}
init${iSpec} : ${singletons
    .map(i => `a${i}`)
    .join(" -> ")} -> Singletons${iSpec} ${singletons
    .map(i => `a${i}`)
    .join(" ")}
init${iSpec} ${singletons.map(i => `a${i}`).join(" ")} =
    Singletons${iSpec}
        { ${singletons.map(i => `a${i} = a${i}`).join(`
        , `)}
        }


{-| Create all singleton specifications for ${iSpec} singleton type${
    iSpec > 1 ? "s" : ""
  }.
-}
specs${iSpec} :
    (${singletons.map(i => `SingletonSpec (${singletonsType}) a${i}`).join(`
     -> `)}
     -> specs
    )
    -> specs
specs${iSpec} fn =
    fn
        ${singletons.map(
          iSingleton => `(Internal.SingletonSpec
            { get = \\(Singletons${iSpec} singletons) -> singletons.a${iSingleton}
            , update =
                \\updateFn (Singletons${iSpec} singletons) ->
                    Singletons${iSpec} (Record${iSpec}.update${iSingleton} updateFn singletons)
            }
        )`
        ).join(`
        `)}`;
};

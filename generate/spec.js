// @ts-check
const { range } = require("./utils");

exports.generate = function(n) {
  const specs = range(n);

  return `module Ecs.Spec exposing
    ( AllComponentsSpec, ComponentSpec
    , ${specs.map(i => `Components${i}, componentSpecs${i}`).join(`
    , `)}
    , SingletonSpec
    , ${specs.map(i => `Singletons${i}, initSingletons${i}, singletonSpecs${i}`)
      .join(`
    , `)}
    )

{-|

@docs AllComponentsSpec, ComponentSpec
${specs.map(i => `@docs Components${i}, componentSpecs${i}`).join(`
`)}
@docs SingletonSpec
${specs.map(i => `@docs Singletons${i}, initSingletons${i}, singletonSpecs${i}`)
  .join(`
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


{-| A specification type for a singleton.
-}
type alias SingletonSpec singletons a =
    Internal.SingletonSpec singletons a
${specs.map(generateComponentSpecs).join(`
`)}
${specs.map(generateSingletonSpecs).join(`
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
componentSpecs${iSpec} :
    (AllComponentsSpec (${componentsType})
     -> ${components.map(i => `ComponentSpec (${componentsType}) a${i}`).join(`
     -> `)}
     -> specs
    )
    -> specs
componentSpecs${iSpec} fn =
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
initSingletons${iSpec} : ${singletons
    .map(i => `a${i}`)
    .join(" -> ")} -> Singletons${iSpec} ${singletons
    .map(i => `a${i}`)
    .join(" ")}
initSingletons${iSpec} ${singletons.map(i => `a${i}`).join(" ")} =
    Singletons${iSpec}
        { ${singletons.map(i => `a${i} = a${i}`).join(`
        , `)}
        }


{-| Create all singleton specifications for ${iSpec} singleton type${
    iSpec > 1 ? "s" : ""
  }.
-}
singletonSpecs${iSpec} :
    (${singletons.map(i => `SingletonSpec (${singletonsType}) a${i}`).join(`
     -> `)}
     -> specs
    )
    -> specs
singletonSpecs${iSpec} fn =
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

// @ts-check
const { range } = require("./utils");

exports.generate = function(n) {
  const specs = range(n);

  return `module Ecs.Spec exposing
    ( Spec, ComponentSpec
    , ${specs.map(i => `Ecs${i}, spec${i}, components${i}`).join(`
    , `)}
    )

{-|

@docs Spec, ComponentSpec
${specs.map(i => `@docs Ecs${i}, spec${i}, components${i}`).join(`
`)}

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
${specs.map(i => `import Ecs.Internal.Record${i} as Record${i}`).join(`
`)}
import Set exposing (Set)


{-| The ecs specification type.
-}
type alias Spec ecs =
    Internal.Spec ecs


{-| A component specification type.
-}
type alias ComponentSpec ecs a =
    Internal.ComponentSpec ecs a
${specs.map(iSpec => {
    const components = range(iSpec);

    const ecs = `Ecs${iSpec} ${components.map(i => `a${i}`).join(" ")}`;
    const data = `Record${iSpec}.Record ${components
      .map(i => `(Dict Int a${i})`)
      .join(" ")}`;

    return `

{-| An ecs model type with ${iSpec} component type${iSpec > 1 ? "s" : ""}.
-}
type ${ecs}
    = Ecs${iSpec}
        { entities :
            { nextId : Int
            , activeIds : Set Int
            }
        , data : ${data}
        }


{-| An ecs specification with ${iSpec} component type${iSpec > 1 ? "s" : ""}.
-}
spec${iSpec} : Spec (${ecs})
spec${iSpec} =
    Internal.Spec
        { empty =
            Ecs${iSpec}
                { entities =
                    { nextId = 0
                    , activeIds = Set.empty
                    }
                , data =
                    { ${components.map(i => `a${i} = Dict.empty`).join(`
                    , `)}
                    }
                }
        , clear =
            \\(Internal.EntityId entityId) (Ecs${iSpec} { entities, data }) ->
                Ecs${iSpec}
                    { entities = entities
                    , data =
                        { ${components.map(
                          i => `a${i} = Dict.remove entityId data.a${i}`
                        ).join(`
                        , `)}
                        }
                    }
        , isEmpty =
            \\(Ecs${iSpec} { data }) ->
                ${components.map(i => `Dict.isEmpty data.a${i}`).join(`
                    && `)}
        , componentCount =
            \\(Ecs${iSpec} { data }) ->
                ${components.map(i => `Dict.size data.a${i}`).join(`
                    + `)}
        , ids =
            \\(Ecs${iSpec} { entities }) ->
                entities.activeIds
        , member =
            \\(Internal.EntityId entityId) (Ecs${iSpec} { entities }) ->
                Set.member entityId entities.activeIds
        , create =
            \\(Ecs${iSpec} { entities, data }) ->
                ( Ecs${iSpec}
                    { entities =
                        { nextId = entities.nextId + 1
                        , activeIds = Set.insert entities.nextId entities.activeIds
                        }
                    , data = data
                    }
                , Internal.EntityId (entities.nextId + 1)
                )
        , destroy =
            \\(Internal.EntityId entityId) (Ecs${iSpec} { entities, data }) ->
                Ecs${iSpec}
                    { entities =
                        { nextId = entities.nextId
                        , activeIds = Set.remove entityId entities.activeIds
                        }

                    -- TODO refactor with clear
                    , data =
                        { ${components.map(
                          i => `a${i} = Dict.remove entityId data.a${i}`
                        ).join(`
                        , `)}
                        }
                    }
        }


{-| Create component specifications for an ecs with ${iSpec} component type${
      iSpec > 1 ? "s" : ""
    }.
-}
components${iSpec} :
    (${components.map(i => `ComponentSpec (${ecs}) a${i}`).join(`
     -> `)}
     -> componentSpecs
    )
    -> componentSpecs
components${iSpec} fn =
    fn
        ${components.map(
          iComponent => `(Internal.ComponentSpec
            { get = \\(Ecs${iSpec} { data }) -> data.a${iComponent}
            , update =
                \\updateFn (Ecs${iSpec} { entities, data }) ->
                    Ecs${iSpec}
                        { entities = entities
                        , data = Record${iSpec}.update${iComponent} updateFn data
                        }
            }
        )`
        ).join(`
        `)}`;
  }).join(`
`)}
`;
};

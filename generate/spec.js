// @ts-check

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
import Set


{-| The ecs specification type.
-}
type alias Spec comparable ecs =
    Internal.Spec comparable ecs


{-| A component specification type.
-}
type alias ComponentSpec comparable ecs a =
    Internal.ComponentSpec comparable ecs a
${specs.map(iSpec => {
    const components = range(iSpec);

    const ecs = `Ecs${iSpec} comparable ${components
      .map(i => `a${i}`)
      .join(" ")}`;

    return `

{-| An ecs model type with ${iSpec} component type${iSpec > 1 ? "s" : ""}.
-}
type ${ecs}
    = Ecs${iSpec}
        { ${components.map(i => `data${i} : Dict comparable a${i}`).join(`
        , `)}
        }


{-| An ecs specification with ${iSpec} component type${iSpec > 1 ? "s" : ""}.
-}
spec${iSpec} : Spec comparable (${ecs})
spec${iSpec} =
    Internal.Spec
        { empty =
            Ecs${iSpec}
                { ${components.map(i => `data${i} = Dict.empty`).join(`
                , `)}
                }
        , clear =
            \\id (Ecs${iSpec} ecs) ->
                Ecs${iSpec}
                    { ${components.map(
                      i => `data${i} = Dict.remove id ecs.data${i}`
                    ).join(`
                    , `)}
                    }
        , isEmpty =
            \\(Ecs${iSpec} ecs) ->
                ${components.map(i => `Dict.isEmpty ecs.data${i}`).join(`
                    && `)}
        , componentCount =
            \\(Ecs${iSpec} ecs) ->
                ${components.map(i => `Dict.size ecs.data${i}`).join(`
                    + `)}
        , ids =
            \\(Ecs${iSpec} ecs) ->
                [ ${components.map(i => `Dict.keys ecs.data${i}`).join(`
                , `)}
                ]
                    |> List.foldl
                        (\\keys a ->
                            List.foldl (\\key b -> Set.insert key b) a keys
                        )
                        Set.empty
        , member =
            \\id (Ecs${iSpec} ecs) ->
                ${components.map(i => `Dict.member id ecs.data${i}`).join(`
                    || `)}
        }


{-| Create component specifications for an ecs with ${iSpec} component type${
      iSpec > 1 ? "s" : ""
    }.
-}
components${iSpec} :
    (${components.map(i => `ComponentSpec comparable (${ecs}) a${i}`).join(`
     -> `)}
     -> componentSpecs
    )
    -> componentSpecs
components${iSpec} fn =
    fn
        ${components.map(
          iComponent => `(Internal.ComponentSpec
            { get = \\(Ecs${iSpec} ecs) -> ecs.data${iComponent}
            , update =
                \\updateFn (Ecs${iSpec} ecs) ->
                    Ecs${iSpec}
                        { ${components.map(
                          i =>
                            `data${i} =${
                              i === iComponent ? " updateFn" : ""
                            } ecs.data${i}`
                        ).join(`
                        , `)}
                        }
            }
        )`
        ).join(`
        `)}`;
  }).join(`
`)}
`;
};

function range(n) {
  return Array(n)
    .fill(0)
    .map((_, index) => index + 1);
}

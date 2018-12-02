// @ts-check

exports.generate = function(n) {
  const specs = range(n);

  return `module Ecs.Spec exposing
    ( Spec, ComponentSpec
    , ${specs.map(i => `Ecs${i}, spec${i}`).join(`
    , `)}
    )

{-|

@docs Spec, ComponentSpec
${specs.map(i => `@docs Ecs${i}, spec${i}`).join(`
`)}

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
import Set


{-| -}
type alias Spec componentSpecs comparable model =
    Internal.Spec componentSpecs comparable model


{-| -}
type alias ComponentSpec comparable model data =
    Internal.ComponentSpec comparable model data
${specs.map(iSpec => {
    const components = range(iSpec);

    const model = `Ecs${iSpec} comparable ${components
      .map(i => `a${i}`)
      .join(" ")}`;

    return `

{-| -}
type ${model}
    = Ecs${iSpec}
        { ${components.map(i => `data${i} : Dict comparable a${i}`).join(`
        , `)}
        }


{-| -}
spec${iSpec} :
    (${components.map(i => `ComponentSpec comparable (${model}) a${i}`).join(`
     -> `)}
     -> componentSpecs
    )
    -> Spec componentSpecs comparable (${model})
spec${iSpec} fn =
    Internal.Spec
        { empty =
            Ecs${iSpec}
                { ${components.map(i => `data${i} = Dict.empty`).join(`
                , `)}
                }
        , clear =
            \\id (Ecs${iSpec} model) ->
                Ecs${iSpec}
                    { ${components.map(
                      i => `data${i} = Dict.remove id model.data${i}`
                    ).join(`
                    , `)}
                    }
        , isEmpty =
            \\(Ecs${iSpec} model) ->
                ${components.map(i => `Dict.isEmpty model.data${i}`).join(`
                    && `)}
        , componentCount =
            \\(Ecs${iSpec} model) ->
                ${components.map(i => `Dict.size model.data${i}`).join(`
                    + `)}
        , ids =
            \\(Ecs${iSpec} model) ->
                [ ${components.map(i => `Dict.keys model.data${i}`).join(`
                , `)}
                ]
                    |> List.foldl
                        (\\keys a ->
                            List.foldl (\\key b -> Set.insert key b) a keys
                        )
                        Set.empty
        , member =
            \\id (Ecs${iSpec} model) ->
                ${components.map(i => `Dict.member id model.data${i}`).join(`
                    || `)}
        , components = components${iSpec} fn
        }


components${iSpec} :
    (${components.map(i => `ComponentSpec comparable (${model}) a${i}`).join(`
     -> `)}
     -> componentSpecs
    )
    -> componentSpecs
components${iSpec} fn =
    fn
        ${components.map(
          iComponent => `(Internal.ComponentSpec
            { get = \\(Ecs${iSpec} model) -> model.data${iComponent}
            , update =
                \\updateFn (Ecs${iSpec} model) ->
                    Ecs${iSpec}
                        { ${components.map(
                          i =>
                            `data${i} =${
                              i === iComponent ? " updateFn" : ""
                            } model.data${i}`
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

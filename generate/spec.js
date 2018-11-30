// @ts-check

exports.generate = function(n) {
  const specs = range(n);

  return `module Ecs.Spec exposing
    ( EcsSpec, ComponentSpec
    , ${specs.map(i => `Model${i}, ecs${i}, components${i}`).join(`
    , `)}
    )

{-|

@docs EcsSpec, ComponentSpec
${specs.map(i => `@docs Model${i}, ecs${i}, components${i}`).join(`
`)}

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
import Set


{-| -}
type alias EcsSpec comparable model =
    Internal.EcsSpec comparable model


{-| -}
type alias ComponentSpec comparable model data =
    Internal.ComponentSpec comparable model data
${specs.map(iSpec => {
    const components = range(iSpec);

    const model = `Model${iSpec} comparable ${components
      .map(i => `a${i}`)
      .join(" ")}`;

    return `

{-| -}
type ${model}
    = Model${iSpec}
        { ${components.map(i => `data${i} : Dict comparable a${i}`).join(`
        , `)}
        }


{-| -}
ecs${iSpec} : EcsSpec comparable (${model})
ecs${iSpec} =
    Internal.EcsSpec
        { empty =
            Model${iSpec}
                { ${components.map(i => `data${i} = Dict.empty`).join(`
                , `)}
                }
        , clear =
            \\id (Model${iSpec} model) ->
                Model${iSpec}
                    { ${components.map(
                      i => `data${i} = Dict.remove id model.data${i}`
                    ).join(`
                    , `)}
                    }
        , isEmpty =
            \\(Model${iSpec} model) ->
                ${components.map(i => `Dict.isEmpty model.data${i}`).join(`
                    && `)}
        , componentCount =
            \\(Model${iSpec} model) ->
                ${components.map(i => `Dict.size model.data${i}`).join(`
                    + `)}
        , ids =
            \\(Model${iSpec} model) ->
                [ ${components.map(i => `Dict.keys model.data${i}`).join(`
                , `)}
                ]
                    |> List.foldl
                        (\\keys a ->
                            List.foldl (\\key b -> Set.insert key b) a keys
                        )
                        Set.empty
        , member =
            \\id (Model${iSpec} model) ->
                ${components.map(i => `Dict.member id model.data${i}`).join(`
                    || `)}
        }


{-| -}
components${iSpec} :
    (${components.map(i => `ComponentSpec comparable (${model}) a${i}`).join(`
     -> `)}
     -> b
    )
    -> b
components${iSpec} fn =
    fn
        ${components.map(
          iComponent => `(Internal.ComponentSpec
            { get = \\(Model${iSpec} model) -> model.data${iComponent}
            , update =
                \\updateFn (Model${iSpec} model) ->
                    Model${iSpec}
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

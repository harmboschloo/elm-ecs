// @ts-check

const fs = require("fs");
const path = require("path");

exports.generate = generate;

function generate(maxComponents, maxNodeComponents, destination) {
  const file = path.resolve(destination, "Types.elm");

  fs.writeFile(file, generateTypes(maxComponents, maxNodeComponents), error => {
    if (error) {
      console.error(error);
    } else {
      console.log(`Generated ${file}`);
    }
  });
}

function generateTypes(n, nNodes) {
  const all = range(n);

  return `module Ecs.Types exposing
    ( EntityType, ComponentType, NodeType
    , ${all
      .map(
        i => `entity${i}, components${i}${i > nNodes ? "" : `, node${i}`}\n    `
      )
      .join(", ")})

{-|


# Types

@docs EntityType, ComponentType, NodeType


${all
    .map(
      i =>
        `# Types with ${i} components.\n\n@docs entity${i}, components${i}${
          i > nNodes ? "" : `, node${i}`
        }\n`
    )
    .join("\n\n")}
-}


type EntityType components
    = EntityType { empty : components }


type ComponentType components component
    = ComponentType
        { getComponent : components -> Maybe component
        , setComponent : Maybe component -> components -> components
        }


type NodeType components node
    = NodeType
        { getNode : components -> Maybe node

        -- TODO, setNode : node -> components -> components
        -- update, remove...
        }

${all
    .map(i => {
      const components = range(i);

      return `
{-| Create a entity type with ${i} component${i > 1 ? "s" : ""}.
-}
entity${i} :
    (${components.map(x => `Maybe component${x}`).join(" -> ")} -> components)
    -> EntityType components
entity${i} createComponents =
    EntityType { empty = createComponents ${components
      .map(x => `Nothing`)
      .join(" ")} }


{-| Create component types with ${i} component${i > 1 ? "s" : ""}.
-}
components${i} :
    (${components
      .map(x => `ComponentType components component${x}`)
      .join(" -> ")} -> componentTypes)
    -> (${components
      .map(x => `Maybe component${x}`)
      .join(" -> ")} -> components)
    -> ${components
      .map(x => `(components -> Maybe component${x})`)
      .join("\n    -> ")}
    -> componentTypes
components${i} createComponentTypes createComponents ${components
        .map(x => `get${x}`)
        .join(" ")} =
    createComponentTypes
        ${components
          .map(
            x => `(ComponentType
            { getComponent = get${x}
            , setComponent =
                \\component data ->
                    createComponents
                        ${components
                          .map(x2 =>
                            x2 == x ? "component" : `(get${x2} data)`
                          )
                          .join("\n                        ")}
            }
        )`
          )
          .join("\n        ")}
${
        i > nNodes
          ? ""
          : `

{-| Create a node with ${i} component${i > 1 ? "s" : ""}.
-}
node${i} :
    (${components.map(x => `component${x}`).join(" -> ")} -> node)
    ${components
      .map(x => `-> ComponentType components component${x}`)
      .join("\n    ")}
    -> NodeType components node
node${i} createNode ${components
              .map(x => `(ComponentType type${x})`)
              .join(" ")} =
    NodeType
        { getNode =
            \\data ->${components.map(getComponent).join("")}${createNode(
              components
            )}
        }
`
      }`;
    })
    .join("\n")}`;
}

function getComponent(x) {
  const pad = padding(x * 2 + 2);
  return `
${pad}case type${x}.getComponent data of
${pad}    Nothing ->
${pad}        Nothing

${pad}    Just component${x} ->`;
}

function createNode(components) {
  const pad = padding(components.length * 2 + 3);
  return `
  ${pad}  Just
  ${pad}      (createNode
  ${pad}          ${components
    .map(x => `component${x}`)
    .join(`\n${pad}            `)}
  ${pad}      )`;
}

function padding(n) {
  return Array(n)
    .fill("    ")
    .join("");
}

function range(n) {
  return Array(n)
    .fill(0)
    .map((_, index) => index + 1);
}

// @ts-check

const fs = require("fs");
const path = require("path");
const { range } = require("./utils");

exports.generate = generate;

function generate(maxComponents, destination) {
  const file = path.resolve(destination, "Ecs/Nodes.elm");

  fs.writeFile(file, generateNodes(maxComponents), error => {
    if (error) {
      console.error(error);
    } else {
      console.log(`Generated ${file}`);
    }
  });
}

function generateNodes(n) {
  const nodes = range(n);

  return `module Ecs.Nodes exposing
    (${nodes.map(i => ` node${i}\n    `).join(",")})

{-| ECS nodes.
-}

import Ecs.Internal exposing (ComponentSpec(..), NodeSpec(..))

${nodes
    .map(i => {
      const components = range(i);

      return `
{-| Create a node with ${i} component${i > 1 ? "s" : ""}.
-}
node${i} :
    (${components.map(x => `component${x}`).join(" -> ")} -> node)
    ${components
      .map(x => `-> ComponentSpec components component${x}`)
      .join("\n    ")}
    -> NodeSpec components node
node${i} createNode ${components
        .map(x => `(ComponentSpec spec${x})`)
        .join(" ")} =
    NodeSpec
        { getNode =
            \\data ->${components.map(getComponent).join("")}${createNode(
        components
      )}
        }
`;
    })
    .join("\n")}`;
}

function getComponent(x) {
  const pad = padding(x * 2 + 2);
  return `
${pad}case spec${x}.getComponent data of
${pad}    Nothing ->
${pad}        Nothing
${pad}
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

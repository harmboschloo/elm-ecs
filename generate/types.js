// @ts-check

const fs = require("fs");
const path = require("path");

exports.generate = generate;

function generate(maxComponents, maxNodeComponents, destination) {
  const file = path.resolve(destination, "Types.elm");

  fs.writeFile(file, generates(maxComponents, maxNodeComponents), error => {
    if (error) {
      console.error(error);
    } else {
      console.log(`Generated ${file}`);
    }
  });
}

function generates(n, nNodes) {
  const all = range(n);

  return `module Ecs.Types exposing
    ( Empty, Component, Node
    , ${all
      .map(
        i => `empty${i}, components${i}${i > nNodes ? "" : `, node${i}`}\n    `
      )
      .join(", ")})

{-|


# Setting up your Ecs with empty, component and node specifications.

@docs Empty, Component, Node


${all
    .map(
      i =>
        `# Create specifications for ${i} components.\n\n@docs empty${i}, components${i}${
          i > nNodes ? "" : `, node${i}`
        }\n`
    )
    .join("\n\n")}
-}


type Empty entity
    = Empty entity


type Component entity a
    = Component
        { get : entity -> Maybe a
        , set : Maybe a -> entity -> entity
        }


type Node entity a
    = Node
        { get : entity -> Maybe a

        -- TODO, set : a -> entity -> entity
        -- update, remove...
        }

${all
    .map(i => {
      const components = range(i);

      return `
{-| Create an empty entity specification for ${i} component${i > 1 ? "s" : ""}.
-}
empty${i} :
    (${components.map(x => `Maybe a${x}`).join(" -> ")} -> entity)
    -> Empty entity
empty${i} createEntity =
    Empty (createEntity ${components.map(x => `Nothing`).join(" ")})


{-| Create entity component specifications for ${i} component${
        i > 1 ? "s" : ""
      }.
-}
components${i} :
    (${components
      .map(x => `Component entity a${x}`)
      .join(" -> ")} -> components)
    -> (${components.map(x => `Maybe a${x}`).join(" -> ")} -> entity)
    -> ${components.map(x => `(entity -> Maybe a${x})`).join("\n    -> ")}
    -> components
components${i} createComponents createEntity ${components
        .map(x => `get${x}`)
        .join(" ")} =
    createComponents
        ${components
          .map(
            x => `(Component
            { get = get${x}
            , set =
                \\a entity ->
                    createEntity
                        ${components
                          .map(x2 => (x2 == x ? "a" : `(get${x2} entity)`))
                          .join("\n                        ")}
            }
        )`
          )
          .join("\n        ")}
${
        i > nNodes
          ? ""
          : `

{-| Create a node specification for ${i} component${i > 1 ? "s" : ""}.
-}
node${i} :
    (${components.map(x => `a${x}`).join(" -> ")} -> b)
    ${components.map(x => `-> Component entity a${x}`).join("\n    ")}
    -> Node entity b
node${i} createNode ${components
              .map(x => `(Component component${x})`)
              .join(" ")} =
    Node
        { get =
            \\entity ->${components.map(get).join("")}${createNode(components)}
        }
`
      }`;
    })
    .join("\n")}`;
}

function get(x) {
  const pad = padding(x * 2 + 2);
  return `
${pad}case component${x}.get entity of
${pad}    Nothing ->
${pad}        Nothing

${pad}    Just a${x} ->`;
}

function createNode(components) {
  const pad = padding(components.length * 2 + 3);
  return `
${pad}    Just
${pad}        (createNode
${pad}            ${components.map(x => `a${x}`).join(`\n${pad}            `)}
${pad}        )`;
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

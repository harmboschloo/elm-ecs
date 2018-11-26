// @ts-check

const fs = require("fs");
const path = require("path");

exports.generate = generate;

function generate(maxComponents, destination) {
  const file = path.resolve(destination, "Ecs/AR/Update.elm");

  fs.writeFile(file, generateCode(maxComponents), error => {
    if (error) {
      console.error(error);
    } else {
      console.log(`Generated ${file}`);
    }
  });
}

function generateCode(n) {
  const all = range(n);

  return `module Ecs.AR.Update exposing
    ( Update
    , ${all.map(i => `updates${i}`).join(", ")}
    )

{-|

@docs Update
@docs ${all.map(i => `updates${i}`).join(", ")}

-}


{-| -}
type alias Update a b =
    Maybe b -> a -> a
${all
    .map(i => {
      const components = range(i);

      return `

{-| -}
updates${i} :
    (${components.map(x => `Update a a${x}`).join(" -> ")} -> b)
    -> (${components.map(x => `Maybe a${x}`).join(" -> ")} -> a)
    -> ${components.map(x => `(a -> Maybe a${x})`).join("\n    -> ")}
    -> b
updates${i} createUpdates createRecord ${components
        .map(x => `get${x}`)
        .join(" ")} =
    createUpdates
        ${components
          .map(
            x =>
              `(\\b a -> createRecord ${components
                .map(x2 => (x2 == x ? "b" : `(get${x2} a)`))
                .join(" ")})`
          )
          .join("\n        ")}`;
    })
    .join("\n")}
`;
}

function range(n) {
  return Array(n)
    .fill(0)
    .map((_, index) => index + 1);
}

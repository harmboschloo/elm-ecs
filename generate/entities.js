// @ts-check

const fs = require("fs");
const path = require("path");
const { range } = require("./utils");

exports.generate = generate;

function generate(maxComponents, destination) {
  range(maxComponents).forEach(n => {
    const file = path.resolve(destination, `Ecs/Entity${n}.elm`);

    fs.writeFile(file, generateEntity(n), error => {
      if (error) {
        console.error(error);
      } else {
        console.log(`Generated ${file}`);
      }
    });
  });
}

function generateEntity(n) {
  const components = range(n);

  return `module Ecs.Entity${n} exposing (entity, components)

{-| ECS entities with ${n} component${n > 1 ? "s" : ""}.
-}

import Ecs.Internal exposing (ComponentSpec(..), EntitySpec(..))


{-| -}
entity :
    (${components.map(x => `Maybe component${x}`).join(" -> ")} -> components)
    -> EntitySpec components
entity createComponents =
    EntitySpec { empty = createComponents ${components
      .map(x => `Nothing`)
      .join(" ")} }


{-| -}
components :
    (${components
      .map(x => `ComponentSpec components component${x}`)
      .join(" -> ")} -> componentSpecs)
    -> (${components
      .map(x => `Maybe component${x}`)
      .join(" -> ")} -> components)
    -> ${components
      .map(x => `(components -> Maybe component${x})`)
      .join("\n    -> ")}
    -> componentSpecs
components createComponentSpecs createComponents ${components
    .map(x => `get${x}`)
    .join(" ")} =
    createComponentSpecs
        ${components
          .map(
            x => `(ComponentSpec
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
`;
}

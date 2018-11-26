// @ts-check

const fs = require("fs");
const path = require("path");

exports.generate = generate;

function generate(maxComponents, destination) {
  const file = path.resolve(destination, "Ecs/AR/Entity.elm");

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

  return `module Ecs.AR.Entity exposing
    ( member, get, set, remove, update
    , ${all.map(i => `empty${i}`).join(", ")}
    )

{-|

@docs member, get, set, remove, update
@docs ${all.map(i => `empty${i}`).join(", ")}

-}

import Ecs.AR.Update exposing (Update)


{-| -}
member : (a -> Maybe b) -> a -> Bool
member getB a =
    case getB a of
        Nothing ->
            False

        Just _ ->
            True


{-| -}
get : (a -> Maybe b) -> a -> Maybe b
get getB a =
    getB a


{-| -}
set : Update a b -> b -> a -> a
set setB b a =
    setB (Just b) a


{-| -}
remove : Update a b -> a -> a
remove setB a =
    setB Nothing a


{-| -}
update : (a -> Maybe b) -> Update a b -> (Maybe b -> Maybe b) -> a -> a
update getB setB fn a =
    setB (fn (getB a)) a

${all
    .map(i => {
      const components = range(i);

      return `
{-| -}
empty${i} : (${components.map(x => `Maybe a${x}`).join(" -> ")} -> a) -> a
empty${i} fn =
    fn ${components.map(x => `Nothing`).join(" ")}
`;
    })
    .join("\n")}`;
}

function range(n) {
  return Array(n)
    .fill(0)
    .map((_, index) => index + 1);
}

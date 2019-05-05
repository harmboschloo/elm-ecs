// @ts-check
const { range } = require("./utils");

exports.generate = function(n) {
  const singletons = range(n);

  const singletonsType = `Singletons${n} ${singletons
    .map(i => `a${i}`)
    .join(" ")}`;

  return `module Ecs.Singletons${n} exposing (Singletons${n}, init, specs)

{-|

@docs Singletons${n}, init, specs

-}

import Ecs.Internal exposing (SingletonSpec(..))


{-| A container type for ${n} singleton type${n > 1 ? "s" : ""}.
-}
type ${singletonsType}
    = Singletons${n}
        { ${singletons.map(i => `a${i} : a${i}`).join(`
        , `)}
        }


{-| Initialize a container type for ${n} singleton type${n > 1 ? "s" : ""}.
-}
init : ${singletons
    .map(i => `a${i}`)
    .join(" -> ")} -> Singletons${n} ${singletons.map(i => `a${i}`).join(" ")}
init ${singletons.map(i => `a${i}`).join(" ")} =
    Singletons${n}
        { ${singletons.map(i => `a${i} = a${i}`).join(`
        , `)}
        }


{-| Create all singleton specifications for ${n} singleton type${
    n > 1 ? "s" : ""
  }.
-}
specs :
    (${singletons.map(i => `SingletonSpec a${i} (${singletonsType})`).join(`
     -> `)}
     -> specs
    )
    -> specs
specs fn =
    fn
        ${singletons.map(
          i => `(SingletonSpec
            { get = \\(Singletons${n} singletons) -> singletons.a${i}
            , set =
                \\a (Singletons${n} singletons) ->
                    Singletons${n}
                        { ${singletons.map(
                          f => `a${f} = ${f === i ? `a` : `singletons.a${f}`}`
                        ).join(`
                        , `)}
                        }
            }
        )`
        ).join(`
        `)}
`;
};

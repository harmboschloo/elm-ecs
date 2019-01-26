// @ts-check

const { range } = require("./utils");

exports.generate = function(n) {
  const fields = range(n);
  const recordType = `Record ${fields.map(i => `a${i}`).join(" ")}`;

  return `module Ecs.Internal.Record${n} exposing
    ( Record
    , ${fields.map(i => `update${i}`).join(`
    , `)}
    )


type alias ${recordType} =
    { ${fields.map(i => `a${i} : a${i}`).join(`
    , `)}
    }

${fields.map(
    current =>
      `
update${current} :
    (a${current} -> a${current})
    -> ${recordType}
    -> ${recordType}
update${current} fn record =
    { ${fields.map(
      i => `a${i} = ${i === current ? `fn record.a${i}` : `record.a${i}`}`
    ).join(`
    , `)}
    }
`
  ).join(`
`)}`;
};

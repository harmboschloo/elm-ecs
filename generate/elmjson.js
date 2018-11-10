// @ts-check

const fs = require("fs");
const path = require("path");
const { range } = require("./utils");

exports.generate = generate;

function generate(maxComponents, destination) {
  const file = path.resolve(destination, "elm.json");

  fs.writeFile(file, generateElmJson(maxComponents), error => {
    if (error) {
      console.error(error);
    } else {
      console.log(`Generated ${file}`);
    }
  });
}

function generateElmJson(n) {
  const entities = range(n);

  return `{
    "type": "package",
    "name": "harmboschloo/elm-ecs",
    "summary": "Entity-Component-System",
    "license": "BSD-3-Clause",
    "version": "1.0.0",
    "exposed-modules": [
        "Ecs",
        ${entities.map(n => `"Ecs.Entity${n}"`).join(",\n        ")},
        "Ecs.Nodes"
    ],
    "elm-version": "0.19.0 <= v < 0.20.0",
    "dependencies": {
        "elm/core": "1.0.0 <= v < 2.0.0"
    },
    "test-dependencies": {
        "elm-explorations/test": "1.0.0 <= v < 2.0.0"
    }
}`;
}

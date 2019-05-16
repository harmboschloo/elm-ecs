// @ts-check

const path = require("path");
const fs = require("fs");
const components = require("./components");
const singletons = require("./singletons");
const { range } = require("./utils");

const nComponents = 50;
const nSingletons = 25;
const outputPath = path.resolve(__dirname, "../src");

range(nComponents).forEach(i => {
  writeFile(`Ecs/Components${i}.elm`, components.generate(i));
});

range(nSingletons).forEach(i => {
  writeFile(`Ecs/Singletons${i}.elm`, singletons.generate(i));
});

updateElmJson();

function updateElmJson() {
  const jsonPath = path.resolve(__dirname, "../elm.json");
  fs.readFile(jsonPath, (error, content) => {
    if (error) {
      throw error;
    }

    const json = JSON.parse(content.toString());

    json["exposed-modules"] = [
      "Ecs",
      "Ecs.EntityComponents",
      ...range(nComponents).map(i => `Ecs.Components${i}`),
      ...range(nSingletons).map(i => `Ecs.Singletons${i}`)
    ];

    const newContent = JSON.stringify(json, null, "  ") + "\n";

    writeFile(jsonPath, newContent);
  });
}

function writeFile(file, code) {
  const filePath = path.resolve(outputPath, file);

  fs.writeFile(filePath, code, error => {
    if (error) {
      console.error(error);
    } else {
      console.log(`Generated ${filePath}`);
    }
  });
}

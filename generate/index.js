// @ts-check

const path = require("path");
const fs = require("fs");
const components = require("./components");
const singletons = require("./singletons");
const record = require("./record");
const { range } = require("./utils");

const n = 15;
const outputPath = path.resolve(__dirname, "../src");

writeFile("Ecs/Components.elm", components.generate(n));
writeFile("Ecs/Singletons.elm", singletons.generate(n));
range(n).forEach(i =>
  writeFile(`Ecs/Internal/Record${i}.elm`, record.generate(i))
);

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

// @ts-check

const path = require("path");
const fs = require("fs");
const spec = require("./spec");
const record = require("./record");
const { range } = require("./utils");

const n = 12;
const outputPath = path.resolve(__dirname, "../src");

writeFile("Ecs/Spec.elm", spec.generate(n));
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

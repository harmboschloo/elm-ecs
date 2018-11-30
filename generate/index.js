// @ts-check

const path = require("path");
const fs = require("fs");
const spec = require("./spec");

const maxComponents = 50;
const outputPath = path.resolve(__dirname, "../src");

writeFile("Ecs/Spec.elm", spec.generate(maxComponents));

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

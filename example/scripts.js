const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");

const generatorDir = path.resolve(__dirname, "ecsGenerator");

module.exports.generateEcs = callback => {
  console.log("generating ecs");

  const workerOutputPath = path.resolve(generatorDir, "build/ecsGenerator.js");
  const ecsOutputPath = path.resolve(__dirname, "src-generated/Ecs.elm");

  elmMake("Worker.elm", workerOutputPath, generatorDir);

  makeDir(ecsOutputPath);

  const { Elm } = require(workerOutputPath);
  const worker = Elm.Worker.init();
  worker.ports.onResult.subscribe(result => {
    fs.writeFileSync(ecsOutputPath, result, "utf8");
    console.log(`ecs written to ${ecsOutputPath}`);
    if (callback) {
      callback();
    }
  });
};

module.exports.buildEcsViewer = () => {
  console.log("building ecs viewer");
  elmMake("Viewer.elm", "build/index.html", generatorDir);
};

module.exports.build = () => {
  console.log("building example");
  elmMake("src/Main.elm", "build/index.html");
};

function elmMake(inputPath, outputPath, cwd = __dirname) {
  execSync(`elm make ${inputPath} --output=${outputPath} --optimize`, {
    stdio: "inherit",
    cwd
  });
}

function makeDir(filePath) {
  const dir = path.dirname(filePath);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir);
  }
}

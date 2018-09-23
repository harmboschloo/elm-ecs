const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");

const generatorDir = path.resolve(__dirname, "ecsGenerator");
const workerInputPath = path.resolve(generatorDir, "Worker.elm");
const workerOutputPath = path.resolve(generatorDir, "build/ecsGenerator.js");
const ecsOutputPath = path.resolve(__dirname, "./src-generated/Ecs.elm");
const ecsOutputDir = path.dirname(ecsOutputPath);

console.log("generating ecs");

execSync(
  `elm make ${workerInputPath} --output=${workerOutputPath} --optimize`,
  {
    stdio: "inherit",
    cwd: generatorDir
  }
);

if (!fs.existsSync(ecsOutputDir)) {
  fs.mkdirSync(ecsOutputDir);
}

const { Elm } = require(workerOutputPath);

const worker = Elm.Worker.init();

worker.ports.onResult.subscribe(result => {
  fs.writeFileSync(ecsOutputPath, result, "utf8");
  console.log(`ecs written to ${ecsOutputPath}`);
});

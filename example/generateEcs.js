const { writeFileSync } = require("fs");
const { execSync } = require("child_process");

const workerInputPath = "./src/EcsGenerator/Worker.elm";
const workerOutputPath = "./src-generated/ecsGenerator.js";
const ecsOutputPath = "./src-generated/Ecs.elm";

console.log("generating ecs");

execSync(
  `elm make ${workerInputPath} --output=${workerOutputPath} --optimize`,
  {
    stdio: "inherit"
  }
);

const { Elm } = require(workerOutputPath);

const worker = Elm.EcsGenerator.Worker.init();

worker.ports.onResult.subscribe(result => {
  writeFileSync(ecsOutputPath, result, "utf8");
  console.log(`ecs written to ${ecsOutputPath}`);
});

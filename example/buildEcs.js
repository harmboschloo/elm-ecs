// @ts-check

const { writeFileSync, watchFile } = require("fs");
const { execSync } = require("child_process");

const build = () => {
  console.log("generating ecs");

  execSync(
    "elm make src/EcsBuilder/Builder.elm --output=src-generated/ecsBuilder.js --optimize",
    { stdio: "inherit" }
  );

  // @ts-ignore
  const { Elm } = require("./src-generated/ecsBuilder");

  const app = Elm.Ecs.Builder.init();

  const onResult = result => {
    app.ports.onResult.unsubscribe(onResult);
    writeFileSync("src-generated/Ecs.elm", result, "utf8");
    console.log("ecs written");
  };

  app.ports.onResult.subscribe(onResult);
};

const tryBuild = () => {
  try {
    build();
  } catch (error) {
    console.error(error);
  }
};

if (process.argv[2] === "--watch") {
  console.log("watching");
  watchFile("src/EcsBuilder/Builder.elm", { interval: 100 }, tryBuild);
}

tryBuild();

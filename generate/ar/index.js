// @ts-check

const fs = require("fs");
const path = require("path");
const entity = require("./entity");
const update = require("./update");

const maxComponents = 50;
const output = path.resolve(__dirname, "../../src");

if (!fs.existsSync(output)) {
  fs.mkdirSync(output);
}

entity.generate(maxComponents, output);
update.generate(maxComponents, output);

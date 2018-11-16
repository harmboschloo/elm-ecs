// @ts-check

const fs = require("fs");
const path = require("path");
const types = require("./types");

const maxComponents = 50;
const maxNodeComponents = 10;
const output = path.resolve(__dirname, "output");

if (!fs.existsSync(output)) {
  fs.mkdirSync(output);
}

types.generate(maxComponents, maxNodeComponents, output);

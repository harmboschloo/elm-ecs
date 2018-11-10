// @ts-check

const path = require("path");
const elmjson = require("./elmjson");
const entities = require("./entities");
const nodes = require("./nodes");

const n = 50;
const root = path.resolve(__dirname, "..");
const src = path.resolve(__dirname, "../src");

elmjson.generate(n, root);
entities.generate(n, src);
nodes.generate(n, src);

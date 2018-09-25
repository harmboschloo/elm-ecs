const { build, buildEcsViewer, generateEcs } = require("./scripts");

buildEcsViewer();
generateEcs(build);

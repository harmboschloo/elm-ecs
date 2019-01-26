// @ts-check

exports.range = function(n) {
  return Array(n)
    .fill(0)
    .map((_, index) => index + 1);
};

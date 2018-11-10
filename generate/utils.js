// @ts-check

exports.range = range;

function range(n) {
  return Array(n)
    .fill(0)
    .map((_, index) => index + 1);
}

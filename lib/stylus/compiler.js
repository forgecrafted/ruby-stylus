var stylus = require('stylus');

function compiler(str, options) {
  var style = stylus(str, options);
  var output = '';
  style.render(function(error, css) {
    if(error) throw error;
    output = css;
  })
  return output;
}

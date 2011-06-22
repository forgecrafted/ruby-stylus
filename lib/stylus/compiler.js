var stylus = require('stylus');

function compiler(str, options, plugins) {
  var style = stylus(str, options);
  var output = '';

  for(var name in plugins) {
    var fn = require(name);
    style.use(fn(plugins[name]));
  }

  style.render(function(error, css) {
    if(error) throw error;
    output = css;
  })
  return output;
}

function convert(str) {
  return stylus.convertCSS(str);
}

function version() {
  return stylus.version;
}
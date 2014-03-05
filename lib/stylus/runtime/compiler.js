var stylus = require('stylus');

function compile(str, options, plugins, imports, apiCalls) {
  var style = stylus(str, options);
  var output = '';

  for(var name in plugins) {
    var fn = require(name);
    style.use(fn(plugins[name]));
  }

  imports.forEach(function(path) {
    style.import(path);
  })

  for(var command in apiCalls) {
    style[command].apply(style, apiCalls[command]);
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
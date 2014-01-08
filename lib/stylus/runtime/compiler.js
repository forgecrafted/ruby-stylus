var stylus = require('stylus');

function compile(str, options, plugins, imports) {
  var style = stylus(str, options);
  var output = '';

  for(var name in plugins) {
    if(name === 'url') {
      style.define('url', stylus.url(plugins[name]));
    } else {
      var fn = require(name);
      style.use(fn(plugins[name]));
    }
  }
  imports.forEach(function(path) {
    style.import(path);
  });

  style.render(function(error, css) {
    if(error) throw error;
    output = css;
  });
  return output;
}

function convert(str) {
  return stylus.convertCSS(str);
}

function version() {
  return stylus.version;
}

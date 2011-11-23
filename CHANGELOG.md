## Changelog

### 0.4.0 (2011-11-23)
[Compare view](https://github.com/lucasmazza/ruby-stylus/compare/v0.3.0...v.0.4.0)

* `@import` directives will be added as dependencies to Sprockets (based on the work by @metaskills on the less-rails).

### 0.3.0 (2011-10-17)
[Compare view](https://github.com/lucasmazza/ruby-stylus/compare/v0.2.2...v.0.3.0)

* This gem now uses the [stylus-source](https://github.com/railsjedi/ruby-stylus-source) gem to bundle the latest [NPM](http://search.npmjs.org/#/stylus) package of Stylus, so there's no setup required to install stylus via `npm install` or cloning it into the `node_modules` folder - Thanks @railsjedi.
* Added a `debug` configuration option, that enables the `linenos` and `firebug` flags on Stylus. Inside Rails, this configuration option will be copied from the `config.assets.debug`;
* Added a global array `import` that handles other stylesheets to include on every compilation process;
* Added a shorthand `Stylus.nib = true` to use the plugin and import it on every processed stylesheet.

### 0.2.2 (2011-09-14)
[Compare view](https://github.com/lucasmazza/ruby-stylus/compare/v0.2.1...v0.2.2)

* ExecJS 1.2.5+ compatibility: Using a custom `ExternalRuntime`.

### 0.2.1 (2011-08-30)
[Compare view](https://github.com/lucasmazza/ruby-stylus/compare/v0.2.0...v0.2.1)

* Removed a hack for a Sprockets loading order issue;
* Testing on 1.9.2, REE and Rubinius thanks to [Travis CI](travis-ci.org/#!/lucasmazza/ruby-stylus);
* Enables compression if `Sprockets` is configured to do so;
* Added Rails and Sprockets tests.

### 0.2.0 (2011-07-14)
[Compare view](https://github.com/lucasmazza/ruby-stylus/compare/v0.1.2...v0.2.0)

* Replaced `stylus:install` with proper generators for Rails 3.1 - now all hooks for the `stylesheet_engine` will generate `.styl` files.

### 0.1.2 (2011-07-08)
[Compare view](https://github.com/lucasmazza/ruby-stylus/compare/v0.1.1...v0.1.2)

* Fixes missing `require` for Rails apps.

### 0.1.1 (2011-07-07)
[Compare view](https://github.com/lucasmazza/ruby-stylus/compare/v0.1.0...v0.1.1)

* Requiring `stylus/tilt` outside the `Railtie`, by [DAddYE](https://github.com/DAddYE).

### 0.1.0 (2011-06-21)
[Compare view](https://github.com/lucasmazza/ruby-stylus/compare/v0.0.3...v0.1.0)

* Support for Stylus plugins via `Stylus.use`.
* Docco documentation live at [http://lucasmazza.github.com/ruby-stylus](http://lucasmazza.github.com/ruby-stylus).


### 0.0.3 (2011-06-06)
[Compare view](https://github.com/lucasmazza/ruby-stylus/compare/v0.0.2...v0.0.3)

* Bugfix: stylus now works in production environment.

### 0.0.2 (2011-06-02)
[Compare view](https://github.com/lucasmazza/ruby-stylus/compare/v0.0.1...v0.0.2)

* Added a Rails Generator called `stylus:install` to copy sample files on your `lib/` folder.
* Added `Stylus.convert` to parse CSS back to Stylus syntax.

### 0.0.1 (2011-05-18)
* Initial Release.

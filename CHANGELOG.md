## Changelog

### 0.2.1
[Compare view](https://github.com/lucasmazza/ruby-stylus/compare/v0.2.0...master)

* Removed a hack for a Sprockets loading order issue;
* Testing on 1.9.2, REE and Rubinius thanks to [Travis CI](travis-ci.org/#!/lucasmazza/ruby-stylus).

### 0.2.0 (211-07-14)
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

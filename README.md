# Ruby Stylus

[![Build Status](https://travis-ci.org/lucasmazza/ruby-stylus.png?branch=0-7-stable)](http://travis-ci.org/lucasmazza/ruby-stylus)

`stylus` is a bridge between your Ruby code and the [Stylus](https://github.com/LearnBoost/stylus) library that runs on [node.js](http://nodejs.org). It has support for the Rails 3.1 asset pipeline (thanks to a [Tilt](https://github.com/rtomayko/tilt) Template) and it's backed by the [ExecJS](https://github.com/sstephenson/execjs) gem.

## Installation

Since version 0.3.0, the [stylus-source](https://github.com/railsjedi/ruby-stylus-source) packages the Stylus source into a Rubygem, so it will be available after installing this gem. The `ruby-source` version will follow the Stylus releases and their versions.

You can replace the Stylus code by placing another version of Stylus on `./node_modules/stylus`, and it will be used instead of the version bundled inside the gem.

**But remember**, you still need the `node` command available on your runtime for this gem to work. `stylus` is also compatible with the Heroku Cedar stack, enabling asset compilation during the deployment of your apps. You can check the [Node.js wiki](https://github.com/joyent/node/wiki/Quick-and-easy-installation) for more info.

## Usage

The interaction is done by the `Stylus` module. You can compile Stylus syntax to CSS, convert it back, enable plugins and tweak some other options:

```ruby
require 'stylus'

# Accepts a raw string or an IO object (File, StringIO or anything that responds to 'read').
Stylus.compile(File.new('application.styl')) # returns the compiled stylesheet.

# Use the :compress option, removing most newlines from the code.
Stylus.compile(File.read('application.styl'), :compress => true)

# Or use the global compress flag
Stylus.compress = true
Stylus.compile(File.read('application.styl'))

# Convert old and boring CSS to awesome Stylus.
Stylus.convert(File.new('file.css'))

# Import plugins directly from Node.js, like nib.
Stylus.use :nib

# Enable debug info, which sends the 'linenos' and 'firebug' options to Stylus.
# If you provide a raw content String to the `Stylus.compile` method, remember to send
# a `:filename` option so Stylus can locate your stylesheet for proper inspection.
Stylus.debug = true
```
### With Rails 3 and the Asset Pipeline.

First of all, remember to add `gem 'stylus'` to your Gemfile inside the `:assets` group, So Rails will require the gem according to your current environment - on production you should serve precompiled versions of your assets instead of compiling on the fly.

Adding `stylus` to your Gemfile should let you work with `.styl` files with the Rails 3.1 Pipeline. Any asset generated with `rails generate` will be created with a `.css.styl` extension.

Any `@import` directive will add the stylesheet as a sprockets dependency, so you can update external libraries and it will reflect on your assets fingerprints. Also, the Sprockets load path (usually `app/assets`, `lib/assets`, `vendor/assets` and the `assets` folder inside any other gem) will be available to your stylesheets.

If the `config.assets.debug` is turned on, Stylus will emit extra comments on your stylesheets to help debugging and inspection using the `linenos` and `firebug` options. Check the [FireStylus extension for Firebug](https://github.com/LearnBoost/stylus/blob/master/docs/firebug.md) for more info.

### `@import` and file extensions.

Stylus and Sprockets file lookups differ on the subject of handling file extensions, and that may hurt a bit.

If you use Stylus `@import` to expose variables, mixins or just to concatenate code, you should use only the `.styl` extension on your imported files. If you use the `.css.styl` form (a convention from Sprockets), Stylus will treat it as a plain CSS file since it has `.css` on its name.

```sass
// imports mixins.styl
@import 'mixins'
```

### `@import` dependency resolution

Because of how sprockets handles dependency resolution for computing
file changes and expiring caches, it is necessary to specify the full import path in your import statements.

That is, given:

    app/assets/stylesheets/
    app/assets/stylesheets/file.styl
    app/assets/stylesheets/some_directory/other_file.styl
    app/assets/stylesheets/some_directory/another_file.styl

Imports should be specified with the full path relative to
`app/assets/stylesheets` regardless of where the file calling the import is. In this example we use the `app/assets` directory, but this also applies to `vendor/assets` and `lib/assets`.

`app/assets/stylesheets/file.styl`

    @import "some_directory/other_file.styl"
    ...

`app/assets/stylesheets/some_directory/other_file.styl`

    @import "some_directory/another_file.styl"
    ...

This will ensure that all changes get reflected when any of the imported
files change. If you don't do this, sprockets will not accurately be
able to keep track of your dependencies.


### Standalone Sprockets usage

If you're using Sprockets outside Rails, on Sinatra or on a plain Rack app, you can wire up Stylus inside a instance of `Sprockets::Environment` with the `Stylus.setup` method.

An example of serving stylesheets from `./stylesheets` using just Sprockets and Rack.

```ruby
require 'sprockets'
require 'stylus/sprockets'

# Serve your stylesheets living on ./stylesheets
assets = Sprockets::Environment.new
assets.append_path('stylesheets')

Stylus.setup(assets)

# Run the Sprockets with Rack
map('/assets') { run assets.index }
```

## Plugins

[Stylus](https://github.com/LearnBoost/stylus) exposes a nice API to create plugins written on [node.js](http://nodejs.org), like [nib](https://github.com/visionmedia/nib). The installation process should be the same as described above for [Stylus](https://github.com/LearnBoost/stylus) (since they're all npm packages after all). You can hook them up on your Ruby code with `Stylus.use`:

```ruby
Stylus.use :fingerprint, :literal => 'caa8c262e23268d2a7062c6217202343b84f472b'
```

Will run something like this in JavaScript:

```javascript
stylus(file).use(fingerprint({literal:'caa8c262e23268d2a7062c6217202343b84f472b'}));
```

## Questions, Bugs or Support

You can [submit an issue](https://github.com/lucasmazza/ruby-stylus/issues) or ping me on [GitHub](http://github.com/lucasmazza) or [Twitter](http://twitter.com/lucasmazza).

For more info about the [Stylus](https://github.com/LearnBoost/stylus) syntax and its features you can check the [project repository](https://github.com/learnboost/stylus) and the docs on the [GitHub page](http://learnboost.github.com/stylus).

## Changelog
[It's available here.](https://github.com/lucasmazza/ruby-stylus/blob/master/CHANGELOG.md)

## License

(The MIT License)

Copyright (c) 2012 Lucas Mazza &lt;luc4smazza@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

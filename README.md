# Ruby Stylus

[![Build Status](https://secure.travis-ci.org/lucasmazza/ruby-stylus.png)](http://travis-ci.org/lucasmazza/ruby-stylus)

`stylus` is a bridge between your Ruby code and the [Stylus](https://github.com/LearnBoost/stylus) library that runs on [node.js](http://nodejs.org). It has support for the Rails 3.1 asset pipeline (thanks to a [Tilt](https://github.com/rtomayko/tilt) Template) and it's backed by the [ExecJS](https://github.com/sstephenson/execjs) gem.

## Installation

Since version 0.3.0, the [stylus-source](https://github.com/railsjedi/ruby-stylus-source) packages the Stylus source into a Rubygems, so it will be available after installing this gem. The `ruby-source` version will follow the Stylus releases and their versions.

You can replace the Stylus code by placing another version of Stylus on `./node_modules/stylus`, and it will be used instead of the version bundled inside the gem.

**But remember**, You still need the `node` command available on your runtime for this gem to work. `stylus` is also compatible with the Heroku Cedar stack, enabling the asset compilation during the deployment of your apps.

## Usage

The interaction is done by the `Stylus` module. You can compile stylus syntax to CSS, convert it back, enable plugins and tweak some other options:

```ruby
require 'stylus'

# Accepts a raw string or an IO object (File, StringIO or anything that responds to 'read').
Stylus.compile(File.new('application.styl')) # returns the compiled stylesheet.

# Using the compress option, removing most newlines from the code.
Stylus.compile(File.read('application.styl'), :compress => true)

# Or use the global compress flag
Stylus.compress = true
Stylus.compile(File.read('application.styl'))

# Converting old and boring CSS to awesome Stylus.
Stylus.convert(File.new('file.css'))

# Importing plugins directly from Node.js, like nib.
Stylus.use :nib

# Enabling debug info, which sends the 'linenos' and 'firebug' options to Stylus.
# If you provide a raw content String to the `Stylus.compile` method, remember to send
# a `:filename` option so Stylus can locate your stylesheet for proper inspection.
Stylus.debug = true
```
### With the Rails 3.1 Asset Pipeline.

Adding `stylus` to your Gemfile should let you work with `.styl` files with the Rails 3.1 Pipeline. Any asset generated with `rails generate` will be created with a `.css.styl` extension.

While [Stylus](https://github.com/LearnBoost/stylus) has a `@import` directive, inside a Rails application you should use the `//= require` directive from Sprockets, so the caching mechanism will look after the changes made on the required file. If you're using mixins (for vendor prefixes or any common statements) or plugins inside your `.styl` files, you should use [Stylus](https://github.com/LearnBoost/stylus) `@import` **and** Sprockets `//= depend_on`. The latter is to ensure the proper dependency management on the Sprockets side.

Any `.styl` file on the Sprockets load path (`app/assets`, `lib/assets`, `vendor/assets` or `assets` folder inside any other gem) will be available via the `@import` directive.

If the `config.assets.debug` is turned on, Stylus will emit exta comments on your stylesheets to help debugging and inspection using the `linenos` and `firebug` options. Check the [FireStylus extension for Firebug](https://github.com/LearnBoost/stylus/blob/master/docs/firebug.md) for more info.

## Plugins

[Stylus](https://github.com/LearnBoost/stylus) exposes a nice API to create plugins written on [node.js](http://nodejs.org), like [nib](https://github.com/visionmedia/nib). The installation process should be same as described above for [Stylus](https://github.com/LearnBoost/stylus) (since they're all npm packages after all). You can hook them'up on your Ruby code with `Stylus.use`:

```ruby
Stylus.use :fingerprint, :literal => 'caa8c262e23268d2a7062c6217202343b84f472b'
```

Will run something like this on javascript:

```javascript
stylus(file).use(fingerprint({literal:'caa8c262e23268d2a7062c6217202343b84f472b'}));
```

## Question, Bugs or Support

You can [submit an issue](https://github.com/lucasmazza/ruby-stylus/issues) or ping me at [GitHub](http://github.com/lucasmazza) or [twitter](http://twitter.com/lucasmazza).

For more info about the [Stylus](https://github.com/LearnBoost/stylus) syntax and it's features you can check the [project repository](https://github.com/learnboost/stylus) and [GitHub page](learnboost.github.com/stylus).

## Changelog
[It's available here.](https://github.com/lucasmazza/ruby-stylus/blob/master/CHANGELOG.md)

## License

(The MIT License)

Copyright (c) 2011 Lucas Mazza &lt;luc4smazza@gmail.com&gt;

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
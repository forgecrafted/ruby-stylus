# Ruby Stylus

[![Build Status](https://secure.travis-ci.org/lucasmazza/ruby-stylus.png)](http://travis-ci.org/lucasmazza/ruby-stylus)

`stylus` is a bridge between your Ruby code and the [Stylus](https://github.com/LearnBoost/stylus) library that runs on [node.js](http://nodejs.org). It has support for the Rails 3.1 asset pipeline (thanks to a [Tilt](https://github.com/rtomayko/tilt) Template) and it's backed by the [ExecJS](https://github.com/sstephenson/execjs) gem.

## Installation

Be sure to have [node.js](http://nodejs.org) available on your system, and [npm](npmjs.org) to install the [Stylus](https://github.com/LearnBoost/stylus) package (but you can also do a manual installation).

### With npm

You can make a local install (inside your application folder, so the package will be at `./node_modules`) or a global one (with the `-g` flag). With a global install you will need to make sure that the global installation folder is present at the `NODE_PATH` env variable. A global install will also enable the [Stylus](https://github.com/LearnBoost/stylus) command line interface.

### Manual

You can clone Stylus [git repository](http://github.com/learnboost/stylus) into `node_modules/stylus`. Any `node` commands and/or shells from the current directory will be able to find the cloned package.

Check your installation with `node -e "require('stylus')"`. It should print something like [this](https://gist.github.com/1182631) and exit successfully.

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

# Enabling debug info, which generate comments on the CSS with the line for the a given selector.
Stylus.debug = true
```
### With the Rails 3.1 Asset Pipeline.

Adding `stylus` to your Gemfile should let you work with `.styl` files with the Rails 3.1 Pipeline. Any asset generated with `rails generate` will be created with a `.css.styl` extension.

While [Stylus](https://github.com/LearnBoost/stylus) has a `@import` directive, inside a Rails application you should use the `//= require` directive from Sprockets, so the caching mechanism will look after the changes made on the required file. If you're using mixins (for vendor prefixes or any common statements) or plugins inside your `.styl` files, you should use [Stylus](https://github.com/LearnBoost/stylus) `@import` **and** Sprockets `//= depend_on`. The latter is to ensure the proper dependency management on the Sprockets side.

Any `.styl` file on the Sprockets load path (`app/assets`, `lib/assets`, `vendor/assets` or `assets` folder inside any other gem) will be available via the `@import` directive.

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
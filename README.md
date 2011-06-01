# Ruby Stylus

`stylus` is a bridge between your Ruby code and the [Stylus](https://github.com/LearnBoost/stylus) library that runs on Node.js. It's aims to be a replacement for the [stylus_rails](https://github.com/lucasmazza/stylus_rails) gem and to support the Rails 3.1 asset pipeline (via [Tilt](https://github.com/rtomayko/tilt)) and other scenarios, backed by the [ExecJS](https://github.com/sstephenson/execjs) gem.

## Usage

First, be sure to have stylus installed in your system. If needed, check the project [README](https://github.com/learnboost/stylus) for more information.

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

### With the Rails 3.1 Asset Pipeline.

Just add the `stylus` gem to your Gemfile and the gem will hook itself into Sprockets and enable the `.styl` templates for your stylesheets. If you're including partial files inside your stylesheets, remember to use the `depend_on` directive on the top of your file so Sprockets can recompile it when the partial changes, as below.

    //= depend_on 'mixins/vendor.styl'
    @import 'mixins/vendor'

    // Code goes here...

## Changelog
[here.](https://github.com/lucasmazza/ruby-stylus/blob/master/CHANGELOG.md)

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
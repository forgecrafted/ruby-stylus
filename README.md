# Ruby Stylus

`stylus` is a bridge between your Ruby code and the [Stylus](https://github.com/LearnBoost/stylus) library that runs on Node.js. It's aims to be a replacement for the [stylus_rails](https://github.com/lucasmazza/stylus_rails) gem, to support the Rails 3.1 asset pipeline (via [Tilt](https://github.com/rtomayko/tilt)) and more agnostic scenarios, backed by the [ExecJS](https://github.com/sstephenson/execjs) gem.

## Usage

First, be sure to have stylus installed in your system. If needed, check the project [README](https://github.com/learnboost/stylus) for more information.

    require 'stylus'

    Stylus.compile(File.read('application.styl')) # returns the compiled stylesheet.

    # Using the compress option
    Stylus.compile(File.read('application.styl'), :compress => true)

    # Or use the global compress flag
    Stylus.compress = true
    Stylus.compile(File.read('application.styl'))

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
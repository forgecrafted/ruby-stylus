# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stylus/version"

Gem::Specification.new do |s|
  s.name        = "stylus"
  s.version     = Stylus::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lucas Mazza"]
  s.email       = ["luc4smazza@gmail.com"]
  s.homepage    = "https://github.com/lucasmazza/ruby-stylus"
  s.summary     = %q{Ruby Stylus Compiler}
  s.description = %q{Bridge library to compile .styl stylesheets from ruby code.}

  s.add_dependency 'execjs'
  s.add_dependency 'stylus-source'

  s.files         = Dir["CHANGELOG.md", "LICENSE", "README.md", "lib/**/*"]
  s.test_files    = Dir["spec/**/*.rb"]
  s.require_paths = ["lib"]
end

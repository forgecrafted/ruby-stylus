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
  # s.add_dependency 'stylus-source'
  s.add_development_dependency 'rspec',       '~> 2.0'
  s.add_development_dependency 'railties',    '~> 3.1.0'
  s.add_development_dependency 'tzinfo'
  s.add_development_dependency 'yajl-ruby'
  s.add_development_dependency 'rocco'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

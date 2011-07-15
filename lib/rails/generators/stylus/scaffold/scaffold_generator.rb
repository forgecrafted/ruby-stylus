require 'rails/generators/css/scaffold/scaffold_generator'

module Stylus
  module Generators
    # Just inherit from the original Generator from Rails
    # because `scaffold.css` it's just to help people to start up
    # their Rails applications.
    class ScaffoldGenerator < Css::Generators::ScaffoldGenerator
    end
  end
end
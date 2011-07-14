require 'stylus'
require 'rails/generators/named_base'

module Stylus
  module Generators
    class ScaffoldGenerator < ::Rails::Generators::NamedBase
      def copy_stylesheet
        dir = ::Rails::Generators::ScaffoldGenerator.source_root
        file = File.join(dir, "scaffold.css")
        contents = Stylus.compile(File.read(file))
        create_file "app/assets/stylesheets/scaffold.css.styl", contents
      end
    end
  end
end
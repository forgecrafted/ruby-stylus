require 'rails/generators/named_base'

module Stylus
  module Generators
    class AssetsGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def copy_stylus
        template 'stylesheet.css.styl', File.join('app/assets/stylesheets', class_path, "#{file_name}.css.styl")
      end
    end
  end
end

module Stylus
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc 'copy Stylus assets templates'
      source_root File.expand_path('../templates', __FILE__)

      def copy_asset_template
        copy_file 'stylesheet.css.styl', 'lib/templates/rails/assets/stylesheet.css.styl'
      end

      def copy_scaffold_template
        copy_file 'scaffold.css.styl', 'lib/templates/rails/resource/scaffold.css.styl'
      end
    end
  end
end

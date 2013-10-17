require 'stylus/tilt/stylus'
# Public: A Tilt template to compile Stylus stylesheets with asset helpers.
module Stylus
  module Rails
    class StylusTemplate < ::Tilt::StylusTemplate

      # Public: The default mime type for stylesheets.
      self.default_mime_type = 'text/css'

      # Internal: Appends stylus mixin for asset_url and asset_path support
      def evaluate(scope, locals, &block)
        @data = build_mixin_body(scope) + data
        super
      end

      protected

      # Internal: Builds body of a mixin
      #
      # Returns string representation of a mixin with asset helper functions
      def build_mixin_body(scope)
        @mixin_body ||= if assets_hash(scope).values.all? {|value| value != '' }
                          <<-STYL
asset-url(key)
  return pair[1] if pair[0] == key for pair in #{assets_hash(scope)[:url]} ()
asset-path(key)
  return pair[1] if pair[0] == key for pair in #{assets_hash(scope)[:path]} ()
image-url = asset-url
image-path = asset-path
                          STYL
                        else
                          ''
                        end
      end

      # Internal: Construct Hash with absolute/relative paths in stylus syntax.
      #
      # Returns string representations of hash in Stylus syntax
      def assets_hash(scope)
        @assets_hash ||= scope.environment.each_logical_path.each_with_object({ :url => '', :path => '' }) do |logical_path, assets_hash|
          unless logical_path =~/.*\.(css|js)$/
            path_to_asset = scope.path_to_asset(logical_path)
            assets_hash[:url] << "('#{logical_path}' url(#{path_to_asset})) "
            assets_hash[:path] << "('#{logical_path}' \"#{path_to_asset}\") "
          end
        end
      end

    end
  end
end

Tilt.register ::Stylus::Rails::StylusTemplate, 'styl'

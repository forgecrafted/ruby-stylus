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
      # Returns string representation of all asset helper mixins
      def build_mixin_body(scope)
        @mixin_body ||= if assets_hash(scope).values.all? {|value| value != '' }
                          <<-STYL
#{generate_helper(scope, 'asset')}
#{generate_helper(scope, 'image')}
#{generate_helper(scope, 'audio')}
#{generate_helper(scope, 'video')}
                          STYL
                        else
                          ''
                        end
      end

      # Internal: Generates stylus mixin pairs for asset types
      # 
      # Returns string representations of mixins in stylus syntax
      def generate_helper(scope, name)
        res = ""
        ['url', 'path'].each do |type|
          asset_pair = assets_hash(scope)[type.to_sym]
          asset_pair = assets_hash(scope, type: name)[type.to_sym] if name != 'asset'
          res += <<-EOS
#{name}-#{type}(key)
  return pair[1] if pair[0] == key for pair in #{asset_pair} ()
          EOS
        end
        return res
      end

      # Internal: Construct Hash with absolute/relative paths in stylus syntax.
      #
      # Returns string representations of hash in Stylus syntax
      def assets_hash(scope, options = {})
        @assets_hash ||= scope.environment.each_logical_path.each_with_object({ :url => '', :path => '' }) do |logical_path, assets_hash|
          unless logical_path =~/.*\.(css|js)$/
            path_to_asset = scope.path_to_asset(logical_path, options)
            assets_hash[:url] << "('#{logical_path}' url(#{path_to_asset})) "
            assets_hash[:path] << "('#{logical_path}' \"#{path_to_asset}\") "
          end
        end
      end

    end
  end
end

Tilt.register ::Stylus::Rails::StylusTemplate, 'styl'

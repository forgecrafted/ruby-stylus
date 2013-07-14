module Helpers
  def create_routes
    destination = File.join(destination_root, "config")

    FileUtils.mkdir_p(destination)
    FileUtils.touch File.join(destination, 'routes.rb')
  end

  def create_app(options = {})
    Rails.application = nil

    Class.new(Rails::Application).tap do |app|
      config = app.config.assets
      assets = app.assets
      config.paths = []

      assets.cache = ActiveSupport::Cache.lookup_store(:null_store)
      config.compress = options[:compress]
      config.debug    = options[:debug]
      config.paths << fixture_root
      config.paths << File.expand_path('javascripts')

      app.config.eager_load = false
      app.config.active_support.deprecation = :log
      app.initialize!
    end
  end

  def fixture_root
    File.expand_path('../../stylesheets', __FILE__)
  end

  def output_root
    File.expand_path('../../cases', __FILE__)
  end

  def fixture(name)
    source = fixture_path(name)
    output = css_path(name)
    [source, output].map do |path|
      File.read(path) if File.file?(path)
    end
  end

  def css_path(name)
    File.join(output_root, "#{name}.css")
  end

  def fixture_path(name)
    File.join(fixture_root, "#{name}.styl")
  end

  def dependencies_on(asset)
    context = env.context_class.new(env, asset.logical_path, asset.pathname)
    context.evaluate(asset.pathname)
    context._dependency_paths
  end
end

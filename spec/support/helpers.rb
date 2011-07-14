module Helpers
  def create_routes
    destination = File.join(destination_root, "config")

    FileUtils.mkdir_p(destination)
    FileUtils.touch File.join(destination, 'routes.rb')
  end

  def fixture_root
    File.expand_path('../../fixtures', __FILE__)
  end

  def fixture(name)
    stylus = File.read(File.join(fixture_root, "#{name}.styl"))
    css    = File.read(File.join(fixture_root, "#{name}.css"))
    [stylus, css]
  end
end

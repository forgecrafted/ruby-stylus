require 'spec_helper'

describe Stylus::ImportProcessor do

  let(:app) { create_app }
  let(:env) { app.assets }
  let(:sprockets) { double(:environment => env) }

  it 'adds an imported stylesheet as a dependency' do
    source = fixture(:import).first
    asset = env['import']
    template = Stylus::ImportProcessor.new { source }
    dependency = Pathname.new(fixture_path('mixins/vendor'))
    sprockets.stub(:resolve) { dependency }

    sprockets.should_receive(:depend_on).with(dependency)
    template.render(sprockets)
  end

end
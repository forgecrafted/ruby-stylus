require 'spec_helper'

describe Stylus::ImportProcessor do

  let(:app) { create_app }
  let(:env) { app.assets }
  let(:context) { double(:environment => env) }

  it 'adds an imported stylesheet as a dependency' do
    source = fixture(:import).first
    asset = env['import']
    template = Stylus::ImportProcessor.new { source }
    dependency = Pathname.new(fixture_path('mixins/vendor'))

    context.should_receive(:depend_on_asset).with(dependency)
    template.render(context)
  end

end
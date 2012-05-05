require 'spec_helper'

describe Stylus::ImportProcessor do
  it 'adds an imported stylesheet as a dependency' do
    source     = fixture(:import).first
    template   = Stylus::ImportProcessor.new { source }
    dependency = Pathname.new(fixture_path('mixins/vendor'))
    sprockets  = double(:resolve => dependency)

    sprockets.should_receive(:depend_on).with(dependency)
    template.render(sprockets)
  end
end
require 'spec_helper'

describe Stylus::ImportProcessor do
  let(:env) do
    Sprockets::Environment.new do |assets|
      assets.append_path fixture_root
      Stylus.setup(assets)
    end
  end

  it 'adds an imported stylesheet as a dependency' do
    asset = env['import']
    dependencies = dependencies_on(asset)

    dependencies.should include(fixture_path('mixins/vendor'))
  end

  context "nested dependencies" do
    it 'walks the dependency chain of imported files' do
      asset = env['nested_import']
      dependencies = dependencies_on(asset)

      dependencies.should include(fixture_path('mixins/nested'))
      dependencies.should include(fixture_path('mixins/vendor'))
    end

    it "adds files referenced in a directory's index file" do
      asset = env['indexed_nested_import']
      dependencies = dependencies_on(asset)

      dependencies.should include(fixture_path('indexed/index'))
      dependencies.should include(fixture_path('indexed/first_dep'))
      dependencies.should include(fixture_path('indexed/second_dep'))
    end

    it "walks dependency chains through indexes" do
      asset = env['indexed_recursive_import']
      dependencies = dependencies_on(asset)

      dependencies.should include(fixture_path('indexed_nested_import'))
      dependencies.should include(fixture_path('indexed/index'))
      dependencies.should include(fixture_path('indexed/first_dep'))
      dependencies.should include(fixture_path('indexed/second_dep'))
    end
  end

  it "swallows errors from files outside the Sprockets paths" do
    source = "@import 'nib'"
    template = Stylus::ImportProcessor.new { source }
    sprockets = double()
    sprockets.should_receive(:resolve).twice.and_raise(::Sprockets::FileNotFound)

    expect {
      template.render(sprockets)
    }.to_not raise_error
  end
end

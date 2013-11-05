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

    expect(dependencies).to include(fixture_path('mixins/vendor'))
  end

  context 'nested dependencies' do
    it 'walks the dependency chain of imported files' do
      asset = env['nested_import']
      dependencies = dependencies_on(asset)

      expect(dependencies).to include(fixture_path('mixins/nested'))
      expect(dependencies).to include(fixture_path('mixins/vendor'))
    end

    it "adds files referenced in a directory's index file" do
      asset = env['indexed_nested_import']
      dependencies = dependencies_on(asset)

      expect(dependencies).to include(fixture_path('indexed/index'))
      expect(dependencies).to include(fixture_path('indexed/first_dep'))
      expect(dependencies).to include(fixture_path('indexed/second_dep'))
    end

    it 'walks dependency chains through indexes' do
      asset = env['indexed_recursive_import']
      dependencies = dependencies_on(asset)

      expect(dependencies).to include(fixture_path('indexed_nested_import'))
      expect(dependencies).to include(fixture_path('indexed/index'))
      expect(dependencies).to include(fixture_path('indexed/first_dep'))
      expect(dependencies).to include(fixture_path('indexed/second_dep'))
    end
  end

  it 'does not process non-stylus files' do
    source = '@import "nib"'
    template = Stylus::ImportProcessor.new('stylesheet.scss') { source }
    context = double

    expect(context).to receive(:environment).and_return(env)
    expect(context).to_not receive(:depend_on)
    template.render(context)
  end

  it 'swallows errors from files outside the Sprockets paths' do
    source = '@import "nib"'
    template = Stylus::ImportProcessor.new { source }
    sprockets = double
    expect(sprockets).to receive(:resolve).twice.and_raise(::Sprockets::FileNotFound)
    expect(template).to receive(:stylus_file?).and_return(true)

    expect {
      template.render(sprockets)
    }.to_not raise_error
  end
end

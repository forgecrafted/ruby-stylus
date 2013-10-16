require 'spec_helper'

describe Stylus do
  it 'compiles the given source' do
    input, output = fixture(:simple)
    expect(Stylus.compile(input)).to eq(output)
  end

  it 'accepts an IO object' do
    input, output = fixture(:simple)
    input = StringIO.new(input)
    expect(Stylus.compile(input)).to eq(output)
  end

  it 'compress the file when the "compress" flag is given' do
    input, output = fixture(:compressed)
    expect(Stylus.compile(input, compress: true)).to eq(output)
  end

  it 'handles the compress flag globally' do
    Stylus.compress = true
    input, output = fixture(:compressed)
    expect(Stylus.compile(input)).to eq(output)
  end

  it 'imports the given paths' do
    path = fixture_root
    input, output = fixture(:import)
    expect(Stylus.compile(input, paths: path)).to eq(output)
  end

  it 'handles the import paths globally' do
    Stylus.paths << fixture_root
    input, output = fixture(:import)
    expect(Stylus.compile(input)).to eq(output)
  end

  it 'implicit imports the given paths' do
    path = File.expand_path('mixins/vendor.styl', fixture_root)
    input, output = fixture(:implicit)
    Stylus.import path
    expect(Stylus.compile(input)).to eq(output)
  end

  it 'outputs both gem and library version' do
    expect(Stylus.version).to match(/Stylus - gem .+ library .+/)
  end

  it 'converts CSS to Stylus' do
    stylus, css = fixture(:stylesheet)
    expect(Stylus.convert(css)).to eq(stylus)
  end

  it 'stores the given plugins' do
    Stylus.use :one, :two, argument: true
    expect(Stylus).to have(2).plugins
  end

  it 'includes the given plugins' do
    Stylus.use :nib
    input, output = fixture(:plugin)
    expect(Stylus.compile(input)).to eq(output)
  end

  it 'includes and imports "nib" automatically' do
    Stylus.nib = true
    input, output = fixture(:nib)
    expect(Stylus.compile(input)).to eq(output)
  end

  it 'share variables between imported stylesheets' do
    input, output = fixture(:variables)
    path = fixture_root

    expect(Stylus.compile(input, paths: path)).to eq(output)
  end

  describe 'The debug flag' do
    let(:path) { fixture_path(:debug) }
    let(:fixture) { File.read(path) }
    let(:file) { File.new(path) }

    before { Stylus.debug = true }

    it 'turns the "linenos" option on' do
      expect(Stylus.compile(file)).to match(/line 1 : #{path}/)
    end

    it 'skips the "linenos" option if no filename is given' do
      expect(Stylus.compile(fixture)).to_not match(/line 1 : #{path}/)
    end

    it 'turns the "firebug" option on' do
      expect(Stylus.compile(file)).to match(/@media -stylus-debug-info/)
    end

    it 'skips the "firebug" option if no filename is given' do
      expect(Stylus.compile(fixture)).to_not match(/@media -stylus-debug-info/)
    end
  end
end

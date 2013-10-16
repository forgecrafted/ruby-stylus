require 'spec_helper'

describe 'Sprockets setup' do
  let(:env) do
    Sprockets::Environment.new do |assets|
      assets.append_path fixture_root
      assets.append_path 'javascripts'
    end
  end

  it 'register the default Tilt template' do
    expect(env).to receive(:register_engine).with('.styl', Tilt::StylusTemplate)
    Stylus.setup(env)
  end

  it 'register a Rails specific Tilt template' do
    expect(env).to receive(:register_engine).with('.styl', Stylus::Rails::StylusTemplate)
    Stylus.setup(env, rails: true)
  end

  it 'register the import processor' do
    expect(env).to receive(:register_preprocessor).with('text/css', Stylus::ImportProcessor)
    Stylus.setup(env)
  end

  it 'copies the asset paths' do
    Stylus.setup(env)
    expect(Stylus.paths).to eq(env.paths)
  end

  it 'configure the debug and compress flags' do
    Stylus.setup(env, debug: true, compress: true)
    expect(Stylus.debug).to be_true
    expect(Stylus.compress).to be_true
  end
end

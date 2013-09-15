require 'spec_helper'

describe "Sprockets setup" do
  let(:env) do
    Sprockets::Environment.new do |assets|
      assets.append_path fixture_root
      assets.append_path 'javascripts'
    end
  end

  it "register the Tilt engine" do
    env.should_receive(:register_engine).with('.styl', Tilt::StylusTemplate)
    Stylus.setup(env)
  end

  it "register the import processor" do
    env.should_receive(:register_preprocessor).with('text/css', Stylus::ImportProcessor)
    Stylus.setup(env)
  end

  it "copies the 'stylesheets' paths" do
    Stylus.setup(env)
    Stylus.paths.should include fixture_root
  end

  it "configure the debug and compress flags" do
    Stylus.setup(env, :debug => true, :compress => true)
    Stylus.debug.should == true
    Stylus.compress.should == true
  end
end

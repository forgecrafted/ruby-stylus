require 'spec_helper'

describe Tilt::StylusTemplate do

  it "is registered for .styl files" do
    Tilt['application.styl'].should == Tilt::StylusTemplate
  end

  it "compiles the given source" do
    input, output = fixture :simple
    template = Tilt::StylusTemplate.new { |t| input }
    template.render.should == output
  end

  it "compiles with the compress option" do
    input, output = fixture :compressed
    template = Tilt::StylusTemplate.new(:compress => true) { |t| input }
    template.render.should == output
  end

end
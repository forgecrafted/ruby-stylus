require 'spec_helper'
require 'stylus/tilt/stylus'

describe Tilt::StylusTemplate do
  it 'registers the template for .styl files' do
    expect(Tilt['application.styl']).to eq(Stylus::Rails::StylusTemplate)
  end

  it 'has a content-type' do
    expect(Tilt::StylusTemplate.default_mime_type).to eq('text/css')
  end

  it 'compiles the given source' do
    input, output = fixture(:simple)
    template = Tilt::StylusTemplate.new { |_| input }
    expect(template.render).to eq(output)
  end

  it 'compiles with the compress option' do
    input, output = fixture(:compressed)
    template = Tilt::StylusTemplate.new(compress: true) { |_| input }
    expect(template.render).to eq(output)
  end
end

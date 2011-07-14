require 'spec_helper'
require 'rails/generators/stylus/assets/assets_generator'

describe Stylus::Generators::AssetsGenerator do
  include Generators::TestCase
  arguments  %w(posts)

  it 'generates a .styl file' do
    file('app/assets/stylesheets/posts.css.styl').should exist
  end
end

require 'spec_helper'
require 'rails/generators/rails/controller/controller_generator'
require 'rails/generators/stylus/assets/assets_generator'

describe Rails::Generators::ControllerGenerator do
  include Generators::TestCase
  arguments  %w(posts --stylesheet-engine=stylus)

  it 'generates a .styl file' do
    file('app/assets/stylesheets/posts.css.styl').should exist
  end
end
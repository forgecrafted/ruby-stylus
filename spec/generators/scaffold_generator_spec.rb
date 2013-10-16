require 'spec_helper'
require 'rails/generators/rails/scaffold/scaffold_generator'
require 'rails/generators/stylus/assets/assets_generator'
require 'rails/generators/stylus/scaffold/scaffold_generator'

describe Rails::Generators::ScaffoldGenerator do
  include Generators::TestCase
  arguments  %w(posts --stylesheet-engine=stylus --orm=false)

  it 'generates the default scaffold stylesheet' do
    expect(file('app/assets/stylesheets/scaffold.css')).to exist
  end

  it 'generates a named .styl file' do
    expect(file('app/assets/stylesheets/posts.css.styl')).to exist
  end
end

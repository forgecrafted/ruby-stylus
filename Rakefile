require 'fileutils'
require 'bundler'
require 'rspec/core/rake_task'
require 'rocco/tasks'
Bundler::GemHelper.install_tasks

desc "Run specs"
RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c -b"]
end

task :default => :spec

Rocco::make 'docs/'

desc 'Builds Rocco docs'
task :docs => :rocco do
  Dir['docs/lib/**/*.html'].each do |file|
    path = file.gsub(/lib/,'')
    FileUtils.mkdir_p(File.dirname(path))
    FileUtils.mv(file, path)
  end
  cp 'docs/stylus.html', 'docs/index.html', :preserve => true
end
directory 'docs/'
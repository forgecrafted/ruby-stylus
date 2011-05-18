require 'bundler'
require 'rspec/core/rake_task'
Bundler::GemHelper.install_tasks

desc "Run specs"
RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c -b"]
end


task :default => :spec
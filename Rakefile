require "bundler/gem_tasks"
begin
  require 'byebug'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:test)
rescue LoadError
  # no rspec available
end

task :default => :test

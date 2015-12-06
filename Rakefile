require "bundler/gem_tasks"
require 'rdoc/task'

begin
  require 'byebug'
  require 'rspec/core/rake_task'
  
  RSpec::Core::RakeTask.new(:test)
rescue LoadError
  # no rspec available
end

desc 'build the rdoc documentation'
task :doc do
    puts %x'rdoc --main=README.md --exclude spec --exclude public' 
end

task :default => :test

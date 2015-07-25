require "bundler/gem_tasks"
begin
  require 'rspec/core/rake_task'

# RSpec::Core::RakeTask.new(:spec, :tag) do |t, task_args|
#   t.rspec_opts = "--tag #{task_args[:tag]}"
# end
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  # no rspec available
end

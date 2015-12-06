module Csgraph
  module CLI
    PATH = File.expand_path(File.join('..', 'cli'), __FILE__)
  end
end

%w(
  execute
).each { |f| require File.join(Csgraph::CLI::PATH, f) }


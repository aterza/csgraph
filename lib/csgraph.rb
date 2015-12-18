require "csgraph/version"

module Csgraph
  PATH = File.expand_path(File.join('..', 'csgraph'), __FILE__)
  EXTENSIONS_PATH = File.expand_path(File.join('..', 'extensions'), __FILE__)
end

#
# Load all core extensions first
#
Dir.glob(File.join(Csgraph::EXTENSIONS_PATH, '*.rb')).each { |f| require f }

%w(
  exceptions
  version
  csound
  dsl
  renderer
  cli
).each { |f| require File.join(Csgraph::PATH, f) }

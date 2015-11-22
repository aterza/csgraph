module Csgraph
  module DSL
    PATH = File.expand_path(File.join('..', 'dsl'), __FILE__)
  end
end

%w(
  exceptions
  p_field
  line
  instr
  definitions
  reader
).each { |f| require File.join(Csgraph::DSL::PATH, f) }

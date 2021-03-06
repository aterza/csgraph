module Csgraph
  module DSL
    PATH = File.expand_path(File.join('..', 'dsl'), __FILE__)
    DEFAULT_CSG_FILE = File.expand_path(File.join(['..'] * 3, 'share', 'csg', 'default.csg'), __FILE__)
  end
end

%w(
  exceptions
  p_field_operations
  p_field_base
  p_field
  p_field_expression
  options
  line
  instr
  definitions
  reader
).each { |f| require File.join(Csgraph::DSL::PATH, f) }

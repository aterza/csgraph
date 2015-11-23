require "csgraph/version"

module Csgraph
	PATH = File.expand_path(File.join('..', 'csgraph'), __FILE__)
end

%w(
	exceptions
	version
	csound
	dsl
	renderer
).each { |f| require File.join(Csgraph::PATH, f) }

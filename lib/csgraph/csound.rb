module Csgraph
	module Csound
	  PATH = File.expand_path(File.join('..', 'csound'), __FILE__)
	end
end

%w(
  score_line
).each { |f| require File.join(Csgraph::Csound::PATH, f) }

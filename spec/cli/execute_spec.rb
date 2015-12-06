require 'spec_helper'

describe Csgraph::CLI do

	it 'should run seamlessly with just one argument' do
	  out = StringIO.new
		Csgraph::CLI.execute([Csgraph::Csound::DEFAULT_SCORE_FILE], out)
# 	expect(out.size).to be > 0
	end

end

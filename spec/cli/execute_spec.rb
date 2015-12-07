require 'spec_helper'

describe Csgraph::CLI do

  it 'should run seamlessly with just one argument' do
    fname = Dir::Tmpname.make_tmpname('csgraph', 'spec.pic')
		ostream = nil
    begin
      ostream = Csgraph::CLI.execute(['-o', "#{fname}", Csgraph::Csound::DEFAULT_SCORE_FILE])
      expect(ostream.size).to be > 0
    ensure
      ostream.close if ostream
      File.unlink(fname)
    end
  end

end

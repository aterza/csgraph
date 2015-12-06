require 'spec_helper'

describe Csgraph::Csound::ScoreFile do

  it 'is created and compiles properly' do
    expect((sf = Csgraph::Csound::ScoreFile.new(Csgraph::Csound::DEFAULT_SCORE_FILE)).class).to be(Csgraph::Csound::ScoreFile)
  end

	it 'compiles and has several score lines at-sorted after creation' do
    expect((sf = Csgraph::Csound::ScoreFile.new(Csgraph::Csound::DEFAULT_SCORE_FILE)).class).to be(Csgraph::Csound::ScoreFile)
		expect(sf.lines.size).to eq(4)
		expect(sf.lines.first.at).to eq(0)
		expect(sf.lines[1].at).to eq(0)
		expect(sf.lines[2].at).to eq(3.2)
		expect(sf.lines[3].at).to eq(6.4)
	end

end

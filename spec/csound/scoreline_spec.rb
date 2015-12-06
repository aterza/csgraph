require 'spec_helper'

describe Csgraph::Csound::ScoreLine do

  before(:example) do
    @sls =
    {
      'i' => { :input => ['i1 0.25 0.5 -18 235.25', '  i 1 0.25 0.5 -18 235.25 ; comment' ], :output => [1, 0.25, 0.5, -18, 235.25] },
      'f' => { :input => [ 'f3 0 4096 10 1 0.5', '  f 3 0 4096 10 1 0.5 ; comment'], :output => [3, 0, 4096, 10, 1, 0.5] },
    }
  end

  it 'cannot be created with new' do
    expect { Csgraph::Csound::ScoreLine.new('whatever') }.to raise_error(NoMethodError, "private method `new' called for Csgraph::Csound::ScoreLine:Class")
  end

  it 'is created with the compile method, selecting the appropriate child' do
    @sls.each do
      |lt, sl_hash|
      sl_hash[:input].each do
        |sl|
        slk = Csgraph::Csound::ScoreLine.compile(sl)
        cname = 'Csgraph::Csound::' + lt.upcase + 'ScoreLine'
        expect(slk.class.name).to eq(cname)
      end
    end
  end

  it 'is compiles properly' do
    @sls.each do
      |lt, sl_hash|
      sl_hash[:input].each do
        |sl|
        slk = Csgraph::Csound::ScoreLine.compile(sl)
        expect(slk.params).to eq(sl_hash[:output])
      end
    end
  end

  it 'returns nil if no recognizable line is passed' do
    sl = ' t 0 23 151 160 ; comment'
    slk = Csgraph::Csound::ScoreLine.compile(sl)
    expect(slk).to be(nil)
  end

  it '\'s render method cannot be called because it it a pure virtual' do
		csg_defs = Csgraph::DSL::Definitions.new
		sl = Csgraph::Csound::ScoreLine.send(:new, 'whatever') # new is private
    expect { sl.render(csg_defs, StringIO.new) }.to raise_error(Csgraph::Exceptions::PureVirtualMethod)
  end

	context 'instrument score line' do

		it 'can discern its own instrument number' do
		  il = @sls['i'][:input].first
		  expect((isl = Csgraph::Csound::ScoreLine.compile(il)).class).to be(Csgraph::Csound::IScoreLine)
			expect(isl.respond_to?(:instr)).to eq(true)
			expect(isl.instr).to eq(1)
		end

	end

	context 'function score line' do

		it 'can discern its own function number' do
		  fl = @sls['f'][:input].first
		  expect((fsl = Csgraph::Csound::ScoreLine.compile(fl)).class).to be(Csgraph::Csound::FScoreLine)
			expect(fsl.respond_to?(:fun)).to eq(true)
			expect(fsl.fun).to eq(3)
		end

	end

end

require 'spec_helper'

describe Csgraph::Csound::ScoreLine do

  before(:example) do
    @sls =
    {
      'i' => { :input => ['i1 0.25 0.5 -18 235.25', '  i 1 0.25 0.5 -18 235.25 ; comment' ], :output => %w(1 0.25 0.5 -18 235.25) },
      'f' => { :input => [ 'f3 0 4096 10 1 0.5', '  f 3 0 4096 10 1 0.5 ; comment'], :output => %w(3 0 4096 10 1 0.5) },
    }
  end

  it 'cannot be created with new' do
    expect { Csgraph::Csound::ScoreLine.new }.to raise_error(NoMethodError, "private method `new' called for Csgraph::Csound::ScoreLine:Class")
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

end

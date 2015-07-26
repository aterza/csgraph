require 'spec_helper'

describe Csgraph::Csound::ScoreLine do

  it 'cannot be created with new' do
    expect { Csgraph::Csound::ScoreLine.new }.to raise_error(NoMethodError, "private method `new' called for Csgraph::Csound::ScoreLine:Class")
  end

  it 'is created with the compile method, selecting the appropriate child' do
    sls = { 'i' => ['i1 0.25 0.5 -18 235.25', '  i 7 0.25 0.5 -18 235.25 ; comment' ], 'f' => [ 'f3 0 4096 10 1', '  f 13 0 4096 10 1 0.5 ; comment'] }
    sls.each do
      |lt, sl_array|
			sl_array.each do
        |sl|
        slk = Csgraph::Csound::ScoreLine.compile(sl)
        cname = 'Csgraph::Csound::' + lt.upcase + 'ScoreLine'
        expect(slk.class.name).to eq(cname)
			end
    end
  end

end

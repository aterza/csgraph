require 'spec_helper'

describe Csgraph::DSL::PField do

  before(:example) do
    @sl = ' i1 0.25 0.5 -18 235.25	; comment'
  end

  it 'can be created with a p-string' do
    p = nil
    expect((p = Csgraph::DSL::PField.create("p5")).class).to be(Csgraph::DSL::PField)
    expect(p.number).to be(5)
  end

  it 'can be created with a p-symbol' do
    p = nil
    expect((p = Csgraph::DSL::PField.create(:p5)).class).to be(Csgraph::DSL::PField)
    expect(p.number).to be(5)
  end

  it 'can accept additions between p-fields and return a PFieldExpression' do
    expect((p2 = Csgraph::DSL::PField.create(:p2)).class).to be(Csgraph::DSL::PField)
    expect((p3 = Csgraph::DSL::PField.create(:p3)).class).to be(Csgraph::DSL::PField)
    expect((p2 + p3).class).to be(Csgraph::DSL::PFieldExpression) 
  end

  it 'does return the proper value' do
		expect((sl = Csgraph::Csound::ScoreLine.compile(@sl)).class).to be(Csgraph::Csound::IScoreLine)
		1.upto(5) do
			|n|
			arg = ('p' + n.to_s)
			pfield = Csgraph::DSL::PField.create(arg)
			expect(pfield.value(sl)).to eq(sl.params[n-1])
		end
  end

end


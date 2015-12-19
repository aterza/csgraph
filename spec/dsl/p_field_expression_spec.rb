require 'spec_helper'

describe Csgraph::DSL::PFieldExpression do

  before(:example) do
    @sl = ' i1 0.25 0.5 -18 235.25  ; comment'
  end

  it 'is created though an operation on p-fields' do
    expect((p2 = Csgraph::DSL::PField.create('p2')).class).to be(Csgraph::DSL::PField)
    expect((p3 = Csgraph::DSL::PField.create(:p3)).class).to be(Csgraph::DSL::PField)
    expect((pe = p2 + p3).class).to be(Csgraph::DSL::PFieldExpression)  
    expect(pe.left).to be(p2)
    expect(pe.right).to be(p3)
    expect(pe.left.number).to be(2)
    expect(pe.right.number).to be(3)
  end

  it 'should check on the validity of its inputs' do
    expect((pfield = Csgraph::DSL::PField.create('p2')).class).to be(Csgraph::DSL::PField)
    expect { Csgraph::DSL::PFieldExpression.new('xxx', pfield, :_plus_) }.to raise_error(Csgraph::DSL::Exceptions::SyntaxError)
    expect { Csgraph::DSL::PFieldExpression.new(pfield, 'xxx', :_plus_) }.to raise_error(Csgraph::DSL::Exceptions::SyntaxError)
  end

  it 'should be able to add a pfield to a constant' do
    expect((p2 = Csgraph::DSL::PField.create('p2')).class).to be(Csgraph::DSL::PField)
    expect((pe = p2 + 23).class).to be(Csgraph::DSL::PFieldExpression)  
    expect(pe.left.number).to eq(2)
    expect(pe.right).to eq(23)
  end

  it 'should be able to add a constant to a pfield' do
    expect((p2 = Csgraph::DSL::PField.create('p2')).class).to be(Csgraph::DSL::PField)
    expect((pe = 23 + p2).class).to be(Csgraph::DSL::PFieldExpression)  
    expect(pe.left).to eq(23)
    expect(pe.right.number).to eq(2)
  end

  it 'should be able to chain expressions and render them' do
    expect((sl = Csgraph::Csound::ScoreLine.compile(@sl)).class).to be(Csgraph::Csound::IScoreLine)
    expect((p2 = Csgraph::DSL::PField.create('p2')).class).to be(Csgraph::DSL::PField)
    expect((p3 = Csgraph::DSL::PField.create(:p3)).class).to be(Csgraph::DSL::PField)
    expect((pe = 23 + p2 + p3).class).to be(Csgraph::DSL::PFieldExpression)  
    expect(pe.value(sl)).to eq(23 + 0.25 + 0.5)
    #
    # let's play it more complicated
    #
    expect((pe = (23 - p2) + p3).class).to be(Csgraph::DSL::PFieldExpression)  
    expect(pe.value(sl)).to eq((23 - 0.25) + 0.5)
  end

  it 'does return the proper value' do
    expect((sl = Csgraph::Csound::ScoreLine.compile(@sl)).class).to be(Csgraph::Csound::IScoreLine)
    p2 = Csgraph::DSL::PField.create(:p2)
    p3 = Csgraph::DSL::PField.create(:p3)
    p5 = Csgraph::DSL::PField.create(:p5)
    offset = 1000
    pe = Csgraph::DSL::PFieldExpression.new(p2, p3, :__plus__)
    expect(pe.value(sl)).to eq(p2.value(sl) + p3.value(sl))
    pe = Csgraph::DSL::PFieldExpression.new(offset, p5, :__minus__)
    expect(pe.value(sl)).to eq(offset - p5.value(sl))
    lnum = 1000
    rnum = 2000
    pe = Csgraph::DSL::PFieldExpression.new(lnum, rnum, :__plus__)
    expect(pe.value(sl)).to eq(lnum + rnum)
  end

end

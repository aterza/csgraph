require 'spec_helper'

describe Csgraph::DSL::PField do

  before(:example) do
    @sl = ' i1 0.25 0.5 -18 235.25  ; comment'
    @sl_with_converters_0 = 'i1 0.25 0.5 -18 8.01 ; 8.01 = 277.15554548439167'
    @sl_with_converters_1 = 'i1 0.25 0.5 -18 8.75 ; 8.75 = 439.95700446074346'
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

  it 'does return the proper value with ampdb and cpspch converters' do
    expect((sl = Csgraph::Csound::ScoreLine.compile(@sl_with_converters_0)).class).to be(Csgraph::Csound::IScoreLine)
    p4 = Csgraph::DSL::PField.create(:p4)
    p4.add_converter(:ampdb)
    p5 = Csgraph::DSL::PField.create(:p5)
    p5.add_converter(:cpspch)
    eps = 0.000001
    expect((p4.value(sl) - 0.12589254117941673).abs).to be < eps
    expect((p5.value(sl) - 277.15554548439167).abs).to be < eps
  end

  it 'does return the proper value with ampdbfs and cpsoct converters' do
    expect((sl = Csgraph::Csound::ScoreLine.compile(@sl_with_converters_1)).class).to be(Csgraph::Csound::IScoreLine)
    p4 = Csgraph::DSL::PField.create(:p4)
    p4.add_converter(:ampdbfs)
    p5 = Csgraph::DSL::PField.create(:p5)
    p5.add_converter(:cpsoct)
    eps = 0.000001
    expect((p4.value(sl) - 4125.246789367127).abs).to be < eps
    expect((p5.value(sl) - 439.95700446074346).abs).to be < eps
  end

end

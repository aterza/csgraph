require 'spec_helper'

describe Csgraph::DSL::PField do

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

end


require 'spec_helper'

describe Csgraph::DSL::PFieldBase do

  it 'has the @coerced property set to false upon creation' do
    expect((p = Csgraph::DSL::PFieldBase.new).class).to be(Csgraph::DSL::PFieldBase)
    expect(p.coerced?).to eq(false)
  end

  it 'can clear the conversion chain' do
    expect((p = Csgraph::DSL::PField.new(:p5)).class).to be(Csgraph::DSL::PField)

    include Csgraph::Csound::Conversions::Cached

    p.add_converter(:cpspch)
    expect(p.converters.size).to eq(1)
    p.clear_converters
    expect(p.converters.size).to eq(0)
  end

end

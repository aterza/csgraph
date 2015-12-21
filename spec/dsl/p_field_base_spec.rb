require 'spec_helper'

describe Csgraph::DSL::PFieldBase do

  it 'has the @coerced property set to false upon creation' do
    expect((p = Csgraph::DSL::PFieldBase.new).class).to be(Csgraph::DSL::PFieldBase)
    expect(p.coerced?).to eq(false)
  end

end

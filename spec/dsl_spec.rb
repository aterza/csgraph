require 'spec_helper'

describe Csgraph::DSL::Definition do

  it 'cannot be created with new' do
    expect { Csgraph::DSL::Definition.new }.to raise_error(NoMethodError, "private method `new' called for Csgraph::DSL::Definition:Class")
  end

	it 'should have a singleton class defined called CsGraph' do
		expect(CsGraph.class).to be(Csgraph::DSL::Definition)
	end

	it 'should have a method called \'define\'' do
		expect(CsGraph.respond_to?(:define)).to be(true)
	end

end

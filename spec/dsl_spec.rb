require 'spec_helper'

describe Csgraph::DSL::Definitions do

  it 'cannot be created with new' do
    expect { Csgraph::DSL::Definitions.new }.to raise_error(NoMethodError, "private method `new' called for Csgraph::DSL::Definitions:Class")
  end

	it 'should have a singleton class defined called CsGraph' do
		expect(CsGraph.class).to be(Csgraph::DSL::Definitions)
	end

	it 'should have a method called \'define\'' do
		expect(CsGraph.respond_to?(:define)).to be(true)
	end

end

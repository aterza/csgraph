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

  it 'should be able to read files through csg_require (*without* .csg)' do
    path = File.join(SPEC_FIXTURE_PATH, 'simple')
    expect(Csgraph::DSL::Reader.csg_require(path)).to be(true)
  end
  
  it 'should be able to read files through csg_require (*with* .csg)' do
    path = File.join(SPEC_FIXTURE_PATH, 'simple.csg')
    expect(Csgraph::DSL::Reader.csg_require(path)).to be(true)
  end
  
  it 'can handle DSL syntax errors' do
    path = File.join(SPEC_FIXTURE_PATH, 'really_wrong')
		expect { Csgraph::DSL::Reader.csg_require(path) }.to raise_error(Csgraph::DSL::Exceptions::SyntaxError) # the actual message can only be matched
  end

end

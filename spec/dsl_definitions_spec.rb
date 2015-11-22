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
    path = File.join(SPEC_FIXTURE_PATH, 'simple_0')
    expect(Csgraph::DSL::Reader.csg_require(path)).to be(true)
  end
  
  it 'should be able to read files through csg_require (*with* .csg)' do
    path = File.join(SPEC_FIXTURE_PATH, 'simple_0.csg')
    expect(Csgraph::DSL::Reader.csg_require(path)).to be(true)
  end

  it 'can handle DSL syntax errors' do
    path = File.join(SPEC_FIXTURE_PATH, 'really_wrong')
		expect { Csgraph::DSL::Reader.csg_require(path) }.to raise_error(Csgraph::DSL::Exceptions::SyntaxError) # the actual message can only be matched
  end
  
  it 'should be able to parse DSL-correct files' do
    path = File.join(SPEC_FIXTURE_PATH, 'simple_1')
    expect(Csgraph::DSL::Reader.csg_require(path)).to be(true)
		#
		# now let's check if the parsing is correct
		#
		expect(CsGraph.keys.size).to eq(4)
		expect(CsGraph.keys).to eq(['1', '2', '3', '4'])
		CsGraph.each do
			|key, content|
			expect(content.class).to be(Csgraph::DSL::Instr)
			expect(content.features.size).to eq(1)
			expect(content.features.first.class).to be(Csgraph::DSL::Line)
			expect(content.features.first.xstart.class).to be(Csgraph::DSL::PField)
			expect(content.features.first.xstart.number).to eq(2)
			expect(content.features.first.xend.class).to be(Csgraph::DSL::PFieldExpression)
			expect(content.features.first.xend.left.number).to eq(2)
			expect(content.features.first.xend.right.number).to eq(3)
			expect(content.features.first.xend.operator).to eq(:+)
			expect(content.features.first.ystart.number).to eq(5)
			expect(content.features.first.yend.number).to eq(5)
		end
  end

end
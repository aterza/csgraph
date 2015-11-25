require 'spec_helper'

describe Csgraph::DSL::Reader do

	include Csgraph::DSL::Reader

  it 'should be able to read files through csg_require (*without* .csg)' do
    path = File.join(SPEC_CSG_FIXTURE_PATH, 'simple_0')
    expect(csg_require(path)).to be(true)
  end
  
  it 'should be able to read files through csg_require (*with* .csg)' do
    path = File.join(SPEC_CSG_FIXTURE_PATH, 'simple_0.csg')
    expect(csg_require(path)).to be(true)
  end

end

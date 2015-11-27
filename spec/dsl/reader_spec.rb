require 'spec_helper'

describe Csgraph::DSL::Reader do

  include Csgraph::DSL::Reader

  it 'should be able to read files through csg_require (*without* .csg)' do
    path = File.join(SPEC_CSG_FIXTURE_PATH, 'simple_0')
    expect(csg_require(path).class).to be(Csgraph::DSL::Definitions)
  end
  
  it 'should be able to read files through csg_require (*with* .csg)' do
    path = File.join(SPEC_CSG_FIXTURE_PATH, 'simple_0.csg')
    expect(csg_require(path).class).to be(Csgraph::DSL::Definitions)
  end

  it 'should raise an error with the wrong filename path' do
    expect { csg_require('does/not/exist') }.to raise_error(Errno::ENOENT, 'No such file or directory @ rb_sysopen - does/not/exist.csg')
  end

end

require 'spec_helper'

describe Csgraph::Renderer do

  it 'should be able to read files through csg_require *and* a csd file' do
    csound_path = File.join(SPEC_CSOUND_FIXTURE_PATH, 'simple.csd')
    csg_path = File.join(SPEC_CSG_FIXTURE_PATH, 'simple_0')
    expect((r = Csgraph::Renderer.new(csound_path, csg_path)).class).to be(Csgraph::Renderer)
		expect(r.send(:read)).to be > 0
		expect(r.score_lines.size).to eq(4)
  end

  it 'should be able to render files' do
    csound_path = File.join(SPEC_CSOUND_FIXTURE_PATH, 'simple.csd')
    csg_path = File.join(SPEC_CSG_FIXTURE_PATH, 'simple_0')
		output_io = StringIO.new
    expect((r = Csgraph::Renderer.new(csound_path, csg_path, output_io)).class).to be(Csgraph::Renderer)
		expect((out = r.render)).to be(output_io)
  end

end

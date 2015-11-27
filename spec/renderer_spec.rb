require 'spec_helper'

describe Csgraph::Renderer do

  it 'should be able to read files through csg_require *and* a csd file' do
    csound_path = File.join(SPEC_CSOUND_FIXTURE_PATH, 'simple.csd')
    csg_path = File.join(SPEC_CSG_FIXTURE_PATH, 'simple_0')
    expect((r = Csgraph::Renderer.new(csg_path)).class).to be(Csgraph::Renderer)
		expect(r.send(:read, csound_path)).to be > 0
		expect(r.score_lines.size).to eq(4)
  end

  it 'should be able to render files' do
    csound_path = File.join(SPEC_CSOUND_FIXTURE_PATH, 'simple.csd')
    csg_path = File.join(SPEC_CSG_FIXTURE_PATH, 'simple_0')
		output_io = StringIO.new
    expect((r = Csgraph::Renderer.new(csg_path, output_io)).class).to be(Csgraph::Renderer)
		expect((out = r.render(csound_path))).to be(output_io)
  end

  it 'should be able to clear its internal score_line buffer' do
    csound_path = File.join(SPEC_CSOUND_FIXTURE_PATH, 'simple.csd')
    csg_path = File.join(SPEC_CSG_FIXTURE_PATH, 'simple_0')
		output_io = StringIO.new
    expect((r = Csgraph::Renderer.new(csg_path, output_io)).class).to be(Csgraph::Renderer)
		expect((out = r.render(csound_path))).to be(output_io)
		expect(r.score_lines.size).to be > 0
		r.send(:clear) # clear is a private method
		expect(r.score_lines.empty?).to be(true)
  end

end

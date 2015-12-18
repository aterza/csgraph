require 'spec_helper'

describe Csgraph::DSL::Instr do

  before(:example) do
    @slt = ' i1 0.25 0.5 -18 235.25  ; comment'
    @slt_result = 'line from Frame.sw+(0.25*hrange,235.25*vrange) to Frame.sw+(0.75*hrange,235.25*vrange) '
    expect((@sl = Csgraph::Csound::ScoreLine.compile(@slt)).class).to be(Csgraph::Csound::IScoreLine)
  end

	it 'does render a pic line when asked to' do
    expect((p2 = Csgraph::DSL::PField.create(:p2)).class).to be(Csgraph::DSL::PField)
    expect((p3 = Csgraph::DSL::PField.create(:p3)).class).to be(Csgraph::DSL::PField)
    expect((p5 = Csgraph::DSL::PField.create(:p5)).class).to be(Csgraph::DSL::PField)
    expect((pdur = Csgraph::DSL::PFieldExpression.new(p2, p3, :__plus__)).class).to be(Csgraph::DSL::PFieldExpression)
		expect((l = Csgraph::DSL::Line.new(p2, pdur, p5, p5)).class).to be(Csgraph::DSL::Line)
		expect((i = Csgraph::DSL::Instr.new(1) { |ins| ins.features << l }).class).to be(Csgraph::DSL::Instr)
		out = i.render(@sl, StringIO.new)
		expect(out.size).to be > 0
		out.rewind
		expect(out.string.chomp).to eq(@slt_result)
	end

end

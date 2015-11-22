require 'spec_helper'

describe Csgraph::DSL::PFieldExpression do

	it 'is created though an operation on p-fields' do
		expect((p2 = Csgraph::DSL::PField.create('p2')).class).to be(Csgraph::DSL::PField)
		expect((p3 = Csgraph::DSL::PField.create(:p3)).class).to be(Csgraph::DSL::PField)
		expect((pe = p2 + p3).class).to be(Csgraph::DSL::PFieldExpression)	
		expect(pe.left).to be(p2)
		expect(pe.right).to be(p3)
		expect(pe.left.number).to be(2)
		expect(pe.right.number).to be(3)
	end

	it 'should check on the validity of its inputs' do
		expect((pfield = Csgraph::DSL::PField.create('p2')).class).to be(Csgraph::DSL::PField)
		expect { Csgraph::DSL::PFieldExpression.new('xxx', pfield, :+) }.to raise_error(Csgraph::DSL::Exceptions::SyntaxError)
		expect { Csgraph::DSL::PFieldExpression.new(pfield, 'xxx', :+) }.to raise_error(Csgraph::DSL::Exceptions::SyntaxError)
	end

end

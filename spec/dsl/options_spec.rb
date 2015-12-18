require 'spec_helper'

describe Csgraph::DSL::Options do

  before(:example) do
    @hash = { :this => 0, :that => 1, :the_other => 3 }
    @allowed = ['this', 'that', 'the_other']
  end

	it 'does clone a normal hash properly' do
    expect((o = Csgraph::DSL::Options.new(@hash, 'test', @allowed)).class).to be(Csgraph::DSL::Options)
	end

	it 'creates a stringified hash' do
    expect((o = Csgraph::DSL::Options.new(@hash, 'test', @allowed)).class).to be(Csgraph::DSL::Options)
    expect(o.keys.map { |k| k.class }).to eq([String, String, String])
	end

  it 'checks its arguments' do
    less_arguments = @allowed - ['the_other']
    expect { Csgraph::DSL::Options.new(@hash, 'test', less_arguments) }.to raise_error(ArgumentError)
  end

end

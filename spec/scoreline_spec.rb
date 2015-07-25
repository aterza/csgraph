require 'spec_helper'

describe Csgraph::Csound::ScoreLine do
  it 'cannot be created with new' do
    expect { Csgraph::Csound::ScoreLine.new }.to raise_error(NoMethodError, "private method `new' called for Csgraph::Csound::ScoreLine:Class")
  end

end

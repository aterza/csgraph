require 'spec_helper'

describe Hash do

  before(:example) do
   @sym_hash = { :this => 1, 'that' => 2, :the_other => 3 }
   @string_keys = ['this', 'that', 'the_other' ].sort
  end

  it 'does stringify a hash (not in place)' do
    expect(@sym_hash.stringify_keys.keys.sort).to eq(@string_keys)
  end

  it 'does stringify a hash (in place)' do
    sh = @sym_hash.dup
    sh.stringify_keys!
    expect(sh.keys.sort).to eq(@string_keys)
  end

end

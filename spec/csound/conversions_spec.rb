require 'spec_helper'

describe Csgraph::Csound::Conversions do

  before(:example) do
    @eps = 0.000001
    @sl = Csgraph::Csound::ScoreLine.compile(' i1 0.25 0.5 -6 235.25')
    @sl_with_converters_0 = Csgraph::Csound::ScoreLine.compile('i1 0.25 0.5 -6 8.01 ; 8.01 = 277.15554548439167')
    @sl_with_converters_1 = Csgraph::Csound::ScoreLine.compile('i1 0.25 0.5 -6 8.75 ; 8.75 = 439.95700446074346')
  end

  context 'actual' do

   extend Csgraph::Csound::Conversions::Actual

   describe 'can perform ampdb() conversions' do
     result = ampdb(-6)
     should_be = 0.5011872336272722
     it 'should be right' do
       expect((result-should_be).abs).to be < @eps
     end
   end

   describe 'can perform ampdbfs() conversions' do
     result = ampdbfs(-6)
     should_be = 0.5011872336272722*Csgraph::Csound::Conversions::Actual::MAXAMP
     it 'should be right' do
       expect((result-should_be).abs).to be < @eps
     end
   end

   describe 'can perform cpspch() conversions' do
     result = cpspch(8.01)
     should_be = 277.15554548439167
     it 'should be right' do
       expect((result-should_be).abs).to be < @eps
     end
   end

   describe 'can perform cpsoct() conversions' do
     result = cpsoct(8.75)
     should_be = 439.95700446074346
     it 'should be right' do
       expect((result-should_be).abs).to be < @eps
     end
   end

  end

  context 'cached' do

   include Csgraph::Csound::Conversions::Cached

   it 'can perform conversions with PFields' do
     #
     # ampdb
     #
     expect((p4 = Csgraph::DSL::PField.create(:p4)).class).to be(Csgraph::DSL::PField)
     ampdb(p4)
     result = 0.5011872336272722
     expect((p4.value(@sl)-result).abs).to be < @eps
     #
     # ampdbfs
     #
     p4.clear_converters
     ampdbfs(p4)
     result = 0.5011872336272722*Csgraph::Csound::Conversions::Actual::MAXAMP
     expect((p4.value(@sl)-result).abs).to be < @eps
     #
     # cpspch
     #
     expect((p5 = Csgraph::DSL::PField.create(:p5)).class).to be(Csgraph::DSL::PField)
     cpspch(p5)
     result = 277.15554548439167
     expect((p5.value(@sl_with_converters_0)-result).abs).to be < @eps
     #
     # cpsoct
     #
     p5.clear_converters
     cpsoct(p5)
     result = 439.95700446074346
     expect((p5.value(@sl_with_converters_1)-result).abs).to be < @eps
   end

   it 'can perform conversions with constants' do
     #
     # ampdb
     #
     result = ampdb(-6)
     should_be = 0.5011872336272722
     expect((result-should_be).abs).to be < @eps
     #
     # ampdbfs
     #
     result = ampdbfs(-6)
     should_be = 0.5011872336272722*Csgraph::Csound::Conversions::Actual::MAXAMP
     expect((result-should_be).abs).to be < @eps
     #
     # cpspch
     #
     result = cpspch(8.01)
     should_be = 277.15554548439167
     expect((result-should_be).abs).to be < @eps
     #
     # cpsoct
     #
     result = cpsoct(8.75)
     should_be = 439.95700446074346
     expect((result-should_be).abs).to be < @eps
   end

  end

end

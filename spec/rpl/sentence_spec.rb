require 'spec_helper'

module Rpl

  describe Sentence do

    describe '#symbols' do

      it 'returns an array of symbols in the sentence' do
        sentence = Sentence.new('PA implies (PB or PC)')
        result = sentence.symbols
        expect(result).to_not be_nil
        expect(result.size).to eq(3)
        expect(result[0]).to eq('PA')
        expect(result[1]).to eq('PB')
        expect(result[2]).to eq('PC')
      end

      it 'returns an empty array if the sentence contains no symbols' do
        sentence = Sentence.new('not True')
        result = sentence.symbols
        expect(result).to be_empty
      end
    end
    
    describe '#to_s' do
      it 'displays the original sentence' do
        sentence = Sentence.new('PA implies (PB or PC)')
        result = sentence.to_s
        expect(result).to_not be_nil
        expect(result).to eq('PA implies (PB or PC)')
      end
    end
  end
end
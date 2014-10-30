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
    
    describe '#is_symbol?' do
      it 'returns true if the sentence is just a symbol' do
        sentence = Sentence.new('PA')
        expect(sentence.is_symbol?).to eq(true)
      end
      
      it 'returns false if the sentence is not a symbol' do
        sentence = Sentence.new('PB iif PA')
        expect(sentence.is_symbol?).to eq(false)
      end
    end
    
    describe '#is_unary_sentence?' do
      it 'returns true if the sentence is a negation' do
        sentence = Sentence.new('not PA')
        expect(sentence.is_unary_sentence?).to eq(true)
      end
      
      it 'returns false if the sentence is binary' do
        sentence = Sentence.new('PC implies (PA or PD)')
        expect(sentence.is_unary_sentence?).to eq(false)
      end
      
      it 'returns false if the sentence is a symbol' do
        sentence = Sentence.new('PA')
        expect(sentence.is_unary_sentence?).to eq(false)
      end
      
      it ' returns false if the sentence is binary but contains a negation' do
        sentence = Sentence.new('PA iif not PC')
        expect(sentence.is_unary_sentence?).to eq(false)
      end
    end
    
    describe '#is_binary_sentence?' do
      it 'returns true if the sentence is a conjunction' do
        sentence = Sentence.new('PA and PB')
        expect(sentence.is_binary_sentence?).to eq(true)
      end
      
      it 'returns true if the sentence is a disjunctions' do
        sentence = Sentence.new('PA or PB')
        expect(sentence.is_binary_sentence?).to eq(true)
      end
      
      it 'returns true if the sentence is an implication' do
        sentence = Sentence.new('PA implies PB')
        expect(sentence.is_binary_sentence?).to eq(true)
      end
      
      it 'returns true if the sentence is a biconditional' do
        sentence = Sentence.new('PA iif PB')
        expect(sentence.is_binary_sentence?).to eq(true)
      end
      
      it 'returns false if the sentence is a negations' do
        sentence = Sentence.new('not PA')
        expect(sentence.is_binary_sentence?).to eq(false)
      end
      
      it 'returns false if the sentence is a symbol' do
        sentence = Sentence.new('PA')
        expect(sentence.is_binary_sentence?).to eq(false)
      end
    end

    describe '#is_true_literal?' do
      it 'returns true if the sentence is the true literal' do
        sentence = Sentence.new('True')
        expect(sentence.is_true_literal?).to eq(true)
      end
      
      it 'returns false if the sentence is the false literal' do
        sentence = Sentence.new('False')
        expect(sentence.is_true_literal?).to eq(false)
      end
      
      it 'returns false if the sentence does not contain the true literal' do
        sentence = Sentence.new('PA and PB')
        expect(sentence.is_true_literal?).to eq(false)
      end
    end

    describe '#is_false_literal?' do
      it 'returns true if the sentence is the false literal' do
        sentence = Sentence.new('False')
        expect(sentence.is_false_literal?).to eq(true)
      end
      
      it 'returns false if the sentence is the true literal' do
        sentence = Sentence.new('True')
        expect(sentence.is_false_literal?).to eq(false)
      end
      
      it 'returns false if the sentence does not contain the false literal' do
        sentence = Sentence.new('PA and PB')
        expect(sentence.is_false_literal?).to eq(false)
      end
    end
  end
end
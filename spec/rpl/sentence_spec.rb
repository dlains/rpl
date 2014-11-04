require 'spec_helper'

module Rpl

  describe Sentence do

    before do
      @sentence = Sentence.new
    end

    describe '#operator' do
      it 'returns nil for simple sentences' do
        expect(@sentence.operator).to be_nil
      end
    end

    describe '#simple_sentence_count' do
      it 'returns zero for simple sentences' do
        expect(@sentence.simple_sentence_count).to eq(0)
      end
    end

    describe '#simple_sentence' do
      it 'returns nil for simple sentences' do
        expect(@sentence.simple_sentence(0)).to be_nil
      end
    end

    describe '#is_not_sentence?' do
      it 'returns false for simple sentences' do
        expect(@sentence.is_not_sentence?).to eq(false)
      end
    end

    describe '#is_and_sentence?' do
      it 'returns false for simple sentences' do
        expect(@sentence.is_and_sentence?).to eq(false)
      end
    end

    describe '#is_or_sentence?' do
      it 'returns false for simple sentences' do
        expect(@sentence.is_or_sentence?).to eq(false)
      end
    end

    describe '#is_implies_sentence?' do
      it 'returns false for simple sentences' do
        expect(@sentence.is_implies_sentence?).to eq(false)
      end
    end

    describe '#is_iif_sentence?' do
      it 'returns false for simple sentences' do
        expect(@sentence.is_iif_sentence?).to eq(false)
      end
    end

    describe '#is_identifier?' do
      it 'returns true for simple sentences' do
        expect(@sentence.is_identifier?).to eq(true)
      end
    end

    describe '#is_true_identifier?' do
      it 'raises a not implemented exception for simple sentences' do
        expect {@sentence.is_true_identifier?}.to raise_error(NotImplementedError)
      end
    end

    describe '#is_false_identifier?' do
      it 'raises a not implemented exception for simple sentences' do
        expect {@sentence.is_false_identifier?}.to raise_error(NotImplementedError)
      end
    end

    describe '#is_unary_sentence?' do
      it 'returns false for simple sentences' do
        expect(@sentence.is_unary_sentence?).to eq(false)
      end
    end
    
    describe '#is_binary_sentence?' do
      it 'returns false for simple sentences' do
        expect(@sentence.is_binary_sentence?).to eq(false)
      end
    end

    # describe '#identifiers' do
    #
    #   it 'returns an array of identifiers in the sentence' do
    #     sentence = Sentence.new('PA implies (PB or PC)')
    #     result = sentence.identifiers
    #     expect(result).to_not be_nil
    #     expect(result.size).to eq(3)
    #     expect(result[0]).to eq('PA')
    #     expect(result[1]).to eq('PB')
    #     expect(result[2]).to eq('PC')
    #   end
    #
    #   it 'returns an empty array if the sentence contains no identifiers' do
    #     sentence = Sentence.new('not True')
    #     result = sentence.identifiers
    #     expect(result).to be_empty
    #   end
    # end
    
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
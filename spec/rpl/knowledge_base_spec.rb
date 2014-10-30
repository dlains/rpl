require 'spec_helper'

module Rpl
  
  describe KnowledgeBase do

    before do
      @kb = Rpl::KnowledgeBase.new
    end

    describe '#as_sentence' do
      it 'should return nil if the knowledge base is empty' do
        sentence = @kb.as_sentence
        expect(sentence).to be_nil
      end

      it 'should return the sentence if there is only one sentence in the knowledge base' do
        @kb.tell('PA iif PB')
      
        sentence = @kb.as_sentence
        expect(sentence).to_not be_nil
        expect(sentence[:iif][:left][:symbol]).to eq('PA')
        expect(sentence[:iif][:right][:symbol]).to eq('PB')
      end

      it 'should join all the sentences in the knowledge base with and clauses' do
        @kb.tell('PA and PB')
        @kb.tell('PB or PC')
      
        sentence = @kb.as_sentence
        expect(sentence).to_not be_nil
        expect(sentence[:and][:left][:and][:left][:symbol]).to eq('PA')
        expect(sentence[:and][:left][:and][:right][:symbol]).to eq('PB')
        expect(sentence[:and][:right][:or][:left][:symbol]).to eq('PB')
        expect(sentence[:and][:right][:or][:right][:symbol]).to eq('PC')
      end
    end

  end
end

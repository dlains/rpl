require 'spec_helper'

module Rpl
  
  describe KnowledgeBase do

    before do
      @kb = Rpl::KnowledgeBase.new
    end

    describe 'tell' do
      it 'adds the sentence to the knowledge base' do
        @kb.tell('not PA')
        expect(@kb.sentences.size).to eq(1)
        expect(@kb.sentences[0].to_s).to eq('not PA')
      end

      it 'does not add duplicate sentences' do
        @kb.tell('not PA')
        expect(@kb.sentences.size).to eq(1)
        @kb.tell('not PA')
        expect(@kb.sentences.size).to eq(1)
      end

      it 'adds multiple sentences to the knowledge base' do
        @kb.tell('not PA', 'PB and PC')
        expect(@kb.sentences.size).to eq(2)
        expect(@kb.to_s).to eq("not PA\nPB and PC")
      end
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
        expect(sentence.operator).to eq(Sentence::OPERATOR_IIF)
        expect(sentence.simple_sentence(0)).to eq('PA')
        expect(sentence.simple_sentence(1)).to eq('PB')
      end

      it 'should join all the sentences in the knowledge base with and clauses' do
        @kb.tell('PA and PB')
        @kb.tell('PB or PC')
      
        sentence = @kb.as_sentence
        expect(sentence).to_not be_nil
        expect(sentence.operator).to eq(Sentence::OPERATOR_AND)
        expect(sentence.simple_sentence(0).operator).to eq(Sentence::OPERATOR_AND)
        expect(sentence.simple_sentence(0).simple_sentence(0)).to eq('PA')
        expect(sentence.simple_sentence(0).simple_sentence(1)).to eq('PB')
        expect(sentence.simple_sentence(1).simple_sentence(0)).to eq('PB')
        expect(sentence.simple_sentence(1).simple_sentence(1)).to eq('PC')
      end
    end

    describe '#to_s' do
      it 'should join all of the sentences in the knowledge base with new lines' do
        @kb.tell('not (PA or PB)')
        @kb.tell('PC iif PD')
        @kb.tell('PE and PF or PG')
        expect(@kb.to_s).to eq("not (PA or PB)\nPC iif PD\nPE and PF or PG")
      end
    end

  end
end

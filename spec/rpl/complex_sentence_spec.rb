require 'spec_helper'

module Rpl

  describe ComplexSentence do

    before do
      @negation_sentence = ComplexSentence.new('not', Identifier.new('PA'))
      @conjunction_sentence = ComplexSentence.new('and', Identifier.new('PA'), Identifier.new('PB'))
      @disjunction_sentence = ComplexSentence.new('or', Identifier.new('PA'), Identifier.new('PB'))
      @implication_sentence = ComplexSentence.new('implies', Identifier.new('PA'), Identifier.new('PB'))
      @biconditional_sentence = ComplexSentence.new('iif', Identifier.new('PA'), Identifier.new('PB'))
    end

    describe '#operator' do
      it 'returns not for negation sentences' do
        expect(@negation_sentence.operator).to eq(Rpl::Sentence::OPERATOR_NOT)
      end
      
      it 'returns and for conjunction sentences' do
        expect(@conjunction_sentence.operator).to eq(Rpl::Sentence::OPERATOR_AND)
      end

      it 'returns or for disjunction sentences' do
        expect(@disjunction_sentence.operator).to eq(Rpl::Sentence::OPERATOR_OR)
      end
      
      it 'returns implies for implication sentences' do
        expect(@implication_sentence.operator).to eq(Rpl::Sentence::OPERATOR_IMPLIES)
      end
      
      it 'returns iif for biconditional sentences' do
        expect(@biconditional_sentence.operator).to eq(Rpl::Sentence::OPERATOR_IIF)
      end
    end

    describe '#simple_sentence_count' do
      it 'returns one for negation sentences' do
        expect(@negation_sentence.simple_sentence_count).to eq(1)
      end

      it 'returns two for conjunction sentences' do
        expect(@conjunction_sentence.simple_sentence_count).to eq(2)
      end

      it 'returns two for disjunction sentences' do
        expect(@disjunction_sentence.simple_sentence_count).to eq(2)
      end

      it 'returns two for implication sentences' do
        expect(@implication_sentence.simple_sentence_count).to eq(2)
      end

      it 'returns two for biconditional sentences' do
        expect(@biconditional_sentence.simple_sentence_count).to eq(2)
      end

    end

    describe '#simple_sentence' do
      it 'returns the requested sentence for complex sentences' do
        expect(@negation_sentence.simple_sentence(0).class).to eq(Identifier)
        expect(@negation_sentence.simple_sentence(0)).to eq('PA')
      end

      it 'returns both parts of a complex sentence' do
        expect(@conjunction_sentence.simple_sentence(0)).to eq('PA')
        expect(@conjunction_sentence.simple_sentence(1)).to eq('PB')
      end
    end

    describe '#is_not_sentence?' do
      it 'returns true for negation sentences' do
        expect(@negation_sentence.is_not_sentence?).to eq(true)
      end

      it 'returns false for other types of sentences' do
        expect(@conjunction_sentence.is_not_sentence?).to eq(false)
        expect(@disjunction_sentence.is_not_sentence?).to eq(false)
        expect(@implication_sentence.is_not_sentence?).to eq(false)
        expect(@biconditional_sentence.is_not_sentence?).to eq(false)
      end
    end

    describe '#is_and_sentence?' do
      it 'returns true for conjunction sentences' do
        expect(@conjunction_sentence.is_and_sentence?).to eq(true)
      end

      it 'returns false for other types of sentences' do
        expect(@negation_sentence.is_and_sentence?).to eq(false)
        expect(@disjunction_sentence.is_and_sentence?).to eq(false)
        expect(@implication_sentence.is_and_sentence?).to eq(false)
        expect(@biconditional_sentence.is_and_sentence?).to eq(false)
      end
    end

    describe '#is_or_sentence?' do
      it 'returns true for disjunction sentences' do
        expect(@disjunction_sentence.is_or_sentence?).to eq(true)
      end

      it 'returns false for other types of sentences' do
        expect(@negation_sentence.is_or_sentence?).to eq(false)
        expect(@conjunction_sentence.is_or_sentence?).to eq(false)
        expect(@implication_sentence.is_or_sentence?).to eq(false)
        expect(@biconditional_sentence.is_or_sentence?).to eq(false)
      end
    end

    describe '#is_implies_sentence?' do
      it 'returns true for implication sentences' do
        expect(@implication_sentence.is_implies_sentence?).to eq(true)
      end

      it 'returns false for other types of sentences' do
        expect(@negation_sentence.is_implies_sentence?).to eq(false)
        expect(@conjunction_sentence.is_implies_sentence?).to eq(false)
        expect(@disjunction_sentence.is_implies_sentence?).to eq(false)
        expect(@biconditional_sentence.is_implies_sentence?).to eq(false)
      end
    end

    describe '#is_iif_sentence?' do
      it 'returns true for biconditional sentences' do
        expect(@biconditional_sentence.is_iif_sentence?).to eq(true)
      end

      it 'returns false for other types of sentences' do
        expect(@negation_sentence.is_iif_sentence?).to eq(false)
        expect(@conjunction_sentence.is_iif_sentence?).to eq(false)
        expect(@disjunction_sentence.is_iif_sentence?).to eq(false)
        expect(@implication_sentence.is_iif_sentence?).to eq(false)
      end
    end

    describe '#is_identifier?' do
      it 'returns false for complex sentences' do
        expect(@negation_sentence.is_identifier?).to eq(false)
      end
    end

    describe '#is_true_identifier?' do
      it 'raises a not implemented exception for complex sentences' do
        expect {@conjunction_sentence.is_true_identifier?}.to raise_error(NotImplementedError)
      end
    end

    describe '#is_false_identifier?' do
      it 'raises a not implemented exception for complex sentences' do
        expect {@disjunction_sentence.is_false_identifier?}.to raise_error(NotImplementedError)
      end
    end

    describe '#is_unary_sentence?' do
      it 'returns true if the sentence is a negation' do
        expect(@negation_sentence.is_unary_sentence?).to eq(true)
      end

      it 'returns false if the sentence is binary' do
        expect(@conjunction_sentence.is_unary_sentence?).to eq(false)
      end
    end
    
    describe '#is_binary_sentence?' do
      it 'returns true if the sentence is a conjunction' do
        expect(@conjunction_sentence.is_binary_sentence?).to eq(true)
      end

      it 'returns true if the sentence is a disjunction' do
        expect(@disjunction_sentence.is_binary_sentence?).to eq(true)
      end

      it 'returns true if the sentence is an implication' do
        expect(@implication_sentence.is_binary_sentence?).to eq(true)
      end

      it 'returns true if the sentence is a biconditional' do
        expect(@biconditional_sentence.is_binary_sentence?).to eq(true)
      end

      it 'returns false if the sentence is a negations' do
        expect(@negation_sentence.is_binary_sentence?).to eq(false)
      end
    end

    describe '#==' do
      it 'returns true if the sentences are equal' do
        long_one = Rpl::Transformer.new.apply(Rpl::Parser.new.parse('(PA and PB) implies not PC'))
        long_two = Rpl::Transformer.new.apply(Rpl::Parser.new.parse('(PA and PB) implies not PC'))
        expect(long_one == long_two).to eq(true)
      end

      it 'returns true if the sentences are identical' do
        expect(@negation_sentence == @negation_sentence).to eq(true)
      end

      it 'returns false if the classes do not match' do
        expect(@conjunction_sentence == 'String').to eq(false)
      end

      it 'returns false if the operators do not match' do
        expect(@disjunction_sentence == @conjunction_sentence).to eq(false)
      end
    end

    describe '#to_s' do
      it 'converts a simple sentence into a string' do
        sentence = build_sentence('PA and PB')
        expect(sentence.to_s).to eq('PA and PB')
      end

      it 'converts a complex sentence into a string' do
        sentence = build_sentence('PA or PB implies PC and PD')
        expect(sentence.to_s).to eq('PA or PB implies PC and PD')
      end
      
      it 'converts a complex sentence and adds parentheses' do
        sentence = build_sentence('(PA iif PB) and PC')
        expect(sentence.to_s).to eq('(PA iif PB) and PC')
      end

      it 'converts a negation into a string' do
        sentence = build_sentence('not (PA and PB)')
        expect(sentence.to_s).to eq('not (PA and PB)')
      end
    end

  end
end

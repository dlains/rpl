require 'spec_helper'

module Rpl

  describe Model do

    describe '#is_true' do
      it 'should return true if the true literal is passed' do
        sentence = Identifier.new('True')
        expect(Rpl::Model.new.is_true?(sentence)).to eq(true)
      end
      
      it 'should return false if the false literal is passed' do
        sentence = Identifier.new('False')
        expect(Rpl::Model.new.is_true?(sentence)).to eq(false)
      end
    end

    describe '#is_false' do
      it 'should return true if the false literal is passed' do
        sentence = Identifier.new('False')
        expect(Rpl::Model.new.is_false?(sentence)).to eq(true)
      end
      
      it 'should return false if the true literal is passed' do
        sentence = Identifier.new('True')
        expect(Rpl::Model.new.is_false?(sentence)).to eq(false)
      end
    end

    describe '#is_unknown?' do
      it 'should return true if the boolean value of the sentence can not be determined' do
        sentence = ComplexSentence.new('or', Identifier.new('PA'), Identifier.new('PB'))
        expect(Rpl::Model.new.is_unknown?(sentence)).to eq(true)
      end

      it 'should return false if the boolean value of the sentence can be determined' do
        sentence = Identifier.new('PA')
        model = Model.new
        model.assignments = {'PA' => true}
        expect(model.is_unknown?(sentence)).to eq(false)
      end
    end

    describe 'eval_identifier' do
      it 'should correctly evaluate the true identifier' do
        true_identifier = build_sentence('True')
        model = Model.new
        expect(model.eval_identifier(true_identifier)).to eq(true)
      end

      it 'should correctly evaluate the false identifier' do
        false_identifier = build_sentence('False')
        model = Model.new
        expect(model.eval_identifier(false_identifier)).to eq(false)
      end

      it 'should correctly evaluate an identifier with a value in the model' do
        identifier = build_sentence('PA')
        expect(unary_model(true).eval_identifier(identifier)).to eq(true)
      end

      it 'should return nil for an identifier with no value in the model' do
        identifier = build_sentence('PC')
        expect(unary_model(true).eval_identifier(identifier)).to be_nil
      end
    end

    describe 'eval_unary_sentence' do
      it 'should correctly evaluate a negated sentence' do
        negation = build_sentence('not PA')
        expect(unary_model(true).eval_unary_sentence(negation)).to eq(false)
        expect(unary_model(false).eval_unary_sentence(negation)).to eq(true)
      end

      it 'should return nil if the identifier is not in the model' do
        negation = build_sentence('not PA')
        model = Model.new
        expect(model.eval_unary_sentence(negation)).to be_nil
      end
    end

    describe 'eval_binary_sentence' do
      it 'should correctly evaluate a conjunction' do
        conjunction = build_sentence('PA and PB')
        expect(binary_model(false, false).eval_binary_sentence(conjunction)).to eq(false)
        expect(binary_model(false, true).eval_binary_sentence(conjunction)).to eq(false)
        expect(binary_model(true, false).eval_binary_sentence(conjunction)).to eq(false)
        expect(binary_model(true, true).eval_binary_sentence(conjunction)).to eq(true)
      end

      it 'should correctly evaluate a disjunction' do
        disjunction = build_sentence('PA or PB')
        expect(binary_model(false, false).eval_binary_sentence(disjunction)).to eq(false)
        expect(binary_model(false, true).eval_binary_sentence(disjunction)).to eq(true)
        expect(binary_model(true, false).eval_binary_sentence(disjunction)).to eq(true)
        expect(binary_model(true, true).eval_binary_sentence(disjunction)).to eq(true)
      end

      it 'should correctly evaluate an implication' do
        implication = build_sentence('PA implies PB')
        expect(binary_model(false, false).eval_binary_sentence(implication)).to eq(true)
        expect(binary_model(false, true).eval_binary_sentence(implication)).to eq(true)
        expect(binary_model(true, false).eval_binary_sentence(implication)).to eq(false)
        expect(binary_model(true, true).eval_binary_sentence(implication)).to eq(true)
      end

      it 'should correctly evaluate a biconditional' do
        biconditional = build_sentence('PA iif PB')
        expect(binary_model(false, false).eval_binary_sentence(biconditional)).to eq(true)
        expect(binary_model(false, true).eval_binary_sentence(biconditional)).to eq(false)
        expect(binary_model(true, false).eval_binary_sentence(biconditional)).to eq(false)
        expect(binary_model(true, true).eval_binary_sentence(biconditional)).to eq(true)
      end

      it 'should return nil if the sentence can not be evaluated' do
        conjunction = build_sentence('PA and PB')
        model = Model.new
        expect(model.eval_binary_sentence(conjunction)).to be_nil
      end
    end

    def unary_model(pa)
      result = Model.new({'PA' => pa})
      return result
    end

    def binary_model(pa, pb)
      result = Model.new({'PA' => pa, 'PB' => pb})
      return result
    end
  end

end

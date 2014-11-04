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
    end

    describe 'eval_unary_sentence' do
      it 'should evaluate a negated sentence' do
        sentence = ComplexSentence.new('not', Identifier.new('PA'))
        model = Model.new
        model.assignments = {'PA' => true}
        expect(model.eval_unary_sentence(sentence)).to eq(false)
      end
    end

  end

end

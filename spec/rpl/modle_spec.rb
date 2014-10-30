require 'spec_helper'

module Rpl

  describe Model do

    describe '#is_true' do
      it 'should return true if the true literal is passed' do
        sentence = Sentence.new('True')
        expect(Rpl::Model.new.is_true?(sentence)).to eq(true)
      end
      
      it 'should return false if the false literal is passed' do
        sentence = Sentence.new('False')
        expect(Rpl::Model.new.is_true?(sentence)).to eq(false)
      end
    end

    describe '#is_false' do
      it 'should return true if the false literal is passed' do
        sentence = Sentence.new('False')
        expect(Rpl::Model.new.is_false?(sentence)).to eq(true)
      end
      
      it 'should return false if the true literal is passed' do
        sentence = Sentence.new('True')
        expect(Rpl::Model.new.is_false?(sentence)).to eq(false)
      end
    end

  end

end

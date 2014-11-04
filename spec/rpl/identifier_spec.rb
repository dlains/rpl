require 'spec_helper'

module Rpl

  describe Identifier do
    describe '#is_true_identifier?' do
      it 'returns true if the identifier is the true literal' do
        identifier = Identifier.new('True')
        expect(identifier.is_true_identifier?).to eq(true)
      end
      
      it 'returns false if the identifier is the false literal' do
        identifier = Identifier.new('False')
        expect(identifier.is_true_identifier?).to eq(false)
      end
    end

    describe '#is_false_identifier?' do
      it 'returns true if the identifier is the false literal' do
        identifier = Identifier.new('False')
        expect(identifier.is_false_identifier?).to eq(true)
      end
      
      it 'returns false if the identifier is the true literal' do
        identifier = Identifier.new('True')
        expect(identifier.is_false_identifier?).to eq(false)
      end
    end

    describe '#==' do
      it 'returns true if the identifiers are equal' do
        identifier = Identifier.new('PA')
        expect(identifier == 'PA').to eq(true)
      end

      it 'returns true if the objects are equal' do
        identifier = Identifier.new('PA')
        expect(identifier == Identifier.new('PA')).to eq(true)
      end

      it 'returns false if the identifiers are not equal' do
        identifier = Identifier.new('PA')
        expect(identifier == 'PB').to eq(false)
      end

      it 'returns false if the objects are not equal' do
        identifier = Identifier.new('PA')
        expect(identifier == Identifier.new('PB')).to eq(false)
      end
    end

  end

end

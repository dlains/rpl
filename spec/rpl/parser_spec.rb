require 'spec_helper'

module Rpl

  describe Parser do

    describe 'complex_sentence' do
      
      def parse_complex_sentence(input)
        return Parser.new.complex_sentence.parse(input)
      end

      # it 'can be surrounded by parentheses' do
      #   result = parse_complex_sentence('( P12 & P13 )')
      #   expect(result.has_key?(:lparen)).to be_truthy
      #   expect(result.has_key?(:rparen)).to be_truthy
      #   expect(result.has_key?(:symbol)).to be_truthy
      # end

      it 'can be a negated symbol' do
        result = parse_complex_sentence('! P12')
        expect(result.has_key?(:not)).to be_truthy
        expect(result.has_key?(:symbol)).to be_truthy
      end
      
      it 'can be a conjunction' do
        result = parse_complex_sentence('P11 & P12')
        expect(result.has_key?(:symbol)).to be_truthy
        expect(result.has_key?(:and)).to be_truthy
      end

      it 'can be a disjunction' do
        result = parse_complex_sentence('P11 | P12')
        expect(result.has_key?(:symbol)).to be_truthy
        expect(result.has_key?(:or)).to be_truthy
      end

    end

    describe 'atomic_sentence' do

      def parse_atomic_sentence(input)
        return Parser.new.atomic_sentence.parse(input)
      end

      it 'can be the true constant' do
        result = parse_atomic_sentence('True')
        expect(result.has_key?(:true)).to be_truthy
      end

      it 'can be the false constant' do
        result = parse_atomic_sentence('False')
        expect(result.has_key?(:false)).to be_truthy
      end

      it 'can be a symbol' do
        result = parse_atomic_sentence('I90')
        expect(result.has_key?(:symbol)).to be_truthy
      end
    end

    describe 'symbol' do
      
      def parse_symbol(input)
        return Parser.new.symbol.parse(input)
      end
      
      it 'starts with an upper case character' do
        result = parse_symbol('Tree')
        expect(result.has_key?(:symbol)).to be_truthy
        result[:symbol] == 'Tree'
      end
      
      it 'can have additional upper case characters' do
        result = parse_symbol('TreeTop')
        expect(result.has_key?(:symbol)).to be_truthy
        result[:symbol] == 'TreeTop'
      end
      
      it 'is delimeted by spaces' do
        result = parse_symbol('Tree ')
        expect(result.has_key?(:symbol)).to be_truthy
        result[:symbol] == 'Tree'
      end
      
      it 'can be a single character' do
        result = parse_symbol('X')
        expect(result.has_key?(:symbol)).to be_truthy
        result[:symbol] == 'X'
      end
      
      it 'can include numbers' do
        result = parse_symbol('Tree10')
        expect(result.has_key?(:symbol)).to be_truthy
        result[:symbol] == 'Tree10'
      end
      
      it 'can not start with a number' do
        expect { parse_symbol('7Tree') }.to raise_error(Parslet::ParseFailed)
      end
      
      it 'can not start with a lower case character' do
        expect { parse_symbol('tree') }.to raise_error(Parslet::ParseFailed)
      end
    end
  end
end
require 'spec_helper'

module Rpl
  
  describe Parser do

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
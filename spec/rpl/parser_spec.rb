require 'spec_helper'

module Rpl
  
  describe Parser do

    describe 'symbol' do
      
      def parse_symbol(input)
        return Parser.new.symbol.parse(input)
      end
      
      it 'starts with an upper case character' do
        result = parse_symbol('Tree')
        result.has_key?(:symbol).should be_true
        result[:symbol] == 'Tree'
      end
      
      it 'can have additional upper case characters' do
        result = parse_symbol('TreeTop')
        result.has_key?(:symbol).should be_true
        result[:symbol] == 'TreeTop'
      end
      
      it 'is delimeted by spaces' do
        result = parse_symbol('Tree ')
        result.has_key?(:symbol).should be_true
        result[:symbol] == 'Tree'
      end
      
      it 'can be a single character' do
        result = parse_symbol('X')
        result.has_key?(:symbol).should be_true
        result[:symbol] == 'X'
      end
      
      it 'can include numbers' do
        result = parse_symbol('Tree10')
        result.has_key?(:symbol).should be_true
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
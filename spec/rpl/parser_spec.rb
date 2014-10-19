require 'spec_helper'
require 'parslet/convenience'

module Rpl

  describe Parser do
    
    it 'can parse a sentence with parentheses' do
      result = Parser.new.parse_with_debug('PA implies (PB or PC)')
      expect(result[:implies][:left][:symbol]).to eq('PA')
      expect(result[:implies][:right][:or][:left][:symbol]).to eq('PB')
      expect(result[:implies][:right][:or][:right][:symbol]).to eq('PC')
    end

    it 'can parse a sentence with nested parentheses' do
      result = Parser.new.parse_with_debug('(PA implies (PB or PC)) and ((PD or PE) implies PF)')
      expect(result[:and][:left][:implies][:left][:symbol]).to eq('PA')
      expect(result[:and][:left][:implies][:right][:or][:left][:symbol]).to eq('PB')
      expect(result[:and][:left][:implies][:right][:or][:right][:symbol]).to eq('PC')
      expect(result[:and][:right][:implies][:left][:or][:left][:symbol]).to eq('PD')
      expect(result[:and][:right][:implies][:left][:or][:right][:symbol]).to eq('PE')
      expect(result[:and][:right][:implies][:right][:symbol]).to eq('PF')
    end

    it 'can parse a negated symbol' do
      result = Parser.new.parse_with_debug('not PA')
      expect(result.has_key?(:not)).to be_truthy
      expect(result[:not][:right][:symbol]).to eq('PA')
    end
    
    it 'can parse a conjunction sentence' do
      result = Parser.new.parse_with_debug('PA and PB')
      expect(result.has_key?(:and)).to be_truthy
      expect(result[:and][:left][:symbol]).to eq('PA')
      expect(result[:and][:right][:symbol]).to eq('PB')
    end

    it 'can parse a disjunction sentence' do
      result = Parser.new.parse_with_debug('PA or PB')
      expect(result.has_key?(:or)).to be_truthy
      expect(result[:or][:left][:symbol]).to eq('PA')
      expect(result[:or][:right][:symbol]).to eq('PB')
    end

    it 'can parse an implies sentence' do
      result = Parser.new.parse_with_debug('(PA and PB) implies not PC')
      expect(result.has_key?(:implies)).to be_truthy
      expect(result[:implies][:left][:and][:left][:symbol]).to eq('PA')
      expect(result[:implies][:left][:and][:right][:symbol]).to eq('PB')
      expect(result[:implies][:right][:not][:right][:symbol]).to eq('PC')
    end

    it 'can parse an iif sentence' do
      result = Parser.new.parse_with_debug('PA iif not PB')
      expect(result.has_key?(:iif)).to be_truthy
      expect(result[:iif][:left][:symbol]).to eq('PA')
      expect(result[:iif][:right][:not][:right][:symbol]).to eq('PB')
    end
    
    it 'can be the true constant' do
      result = Parser.new.parse_with_debug('True')
      expect(result.has_key?(:true)).to be_truthy
      expect(result[:true]).to eq('True')
    end

    it 'can be the false constant' do
      result = Parser.new.parse_with_debug('False')
      expect(result.has_key?(:false)).to be_truthy
      expect(result[:false]).to eq('False')
    end

    it 'can be a symbol' do
      result = Parser.new.parse_with_debug('I90')
      expect(result.has_key?(:symbol)).to be_truthy
      expect(result[:symbol]).to eq('I90')
    end

    describe 'symbol' do
      
      def parse_symbol(input)
        return Parser.new.symbol.parse(input)
      end
      
      it 'starts with an upper case character' do
        result = parse_symbol('Tree')
        expect(result.has_key?(:symbol)).to be_truthy
        expect(result[:symbol]).to eq('Tree')
      end
      
      it 'can have additional upper case characters' do
        result = parse_symbol('TreeTop')
        expect(result.has_key?(:symbol)).to be_truthy
        expect(result[:symbol]).to eq('TreeTop')
      end
      
      it 'is delimeted by spaces' do
        result = parse_symbol('Tree ')
        expect(result.has_key?(:symbol)).to be_truthy
        expect(result[:symbol]).to eq('Tree')
      end
      
      it 'can be a single character' do
        result = parse_symbol('X')
        expect(result.has_key?(:symbol)).to be_truthy
        expect(result[:symbol]).to eq('X')
      end
      
      it 'can include numbers' do
        result = parse_symbol('Tree10')
        expect(result.has_key?(:symbol)).to be_truthy
        expect(result[:symbol]).to eq('Tree10')
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
require 'spec_helper'

module Rpl

  describe Transformer do

    it 'transforms the proposition sentence into a useful AST' do
      parsed = Parser.new.parse('PA or PB implies PC')
      ast = Transformer.new.apply(parsed)
      expect(ast.class).to eq(ComplexSentence)
      expect(ast.simple_sentence(0).class).to eq(ComplexSentence)
      expect(ast.simple_sentence(1).class).to eq(Identifier)
    end

  end

end

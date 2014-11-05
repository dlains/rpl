module Rpl
  class Transformer < Parslet::Transform
    rule(:symbol => simple(:symbol)) { Identifier.new(symbol.to_s) }
    rule(:true => simple(:t))        { Identifier.new(t.to_s) }
    rule(:false => simple(:f))       { Identifier.new(f.to_s) }

    rule(:iif => { :left => subtree(:left), :right => subtree(:right) }) do
      ComplexSentence.new(Rpl::Sentence::OPERATOR_IIF, left, right)
    end
    
    rule(:implies => { :left => subtree(:left), :right => subtree(:right) }) do
      ComplexSentence.new(Rpl::Sentence::OPERATOR_IMPLIES, left, right)
    end
    
    rule(:or => { :left => subtree(:left), :right => subtree(:right) }) do
      ComplexSentence.new(Rpl::Sentence::OPERATOR_OR, left, right)
    end
    
    rule(:and => { :left => subtree(:left), :right => subtree(:right) }) do
      ComplexSentence.new(Rpl::Sentence::OPERATOR_AND, left, right)
    end
    
    rule(:not => { :right => subtree(:right) }) do
      ComplexSentence.new(Rpl::Sentence::OPERATOR_NOT, right)
    end
  end
end

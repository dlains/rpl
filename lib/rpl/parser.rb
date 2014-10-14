require 'parslet'

class Rpl::Parser < Parslet::Parser
  # Start with a logic sentence.
  # root :sentence
  # 
  # # Sentence structure.
  # rule(:sentence) {
  #   atomic_sentence |
  #   complex_sentence
  # }
  # 
  # rule(:atomic_sentence)  { 
  #   predicate                                |
  #   predicate >> lparen >> arglist >> rparen |
  #   term >> op_equals >> term
  # }
  # 
  # rule(:complex_sentence) { 
  #   lparen >> sentence >> rparen          |
  #   op_not >> sentence                    |
  #   sentence >> op_and >> sentence        |
  #   sentence >> op_or >> sentence         |
  #   sentent >> op_implies >> sentence     |
  #   sentence >> op_iif >> sentence        |
  #   quantifier >> varlist >> sentence     |
  # }
  # 
  # # Terms
  # rule(:term) {
  #   function >> lparen >> arglist >> rparen |
  #   constant                                |
  #   variable
  # }
  # 
  # rule(:contant)          { match('[A-Z]').repeat(1) }
  # rule(:variable)         { match('[a-z]').repeat(1) }
  # 
  # rule(:arglist)          { term >> (comma >> term).maybe }
  # rule(:varlist)          { variable >> (comma >> variable).maybe }
  # 
  # # Quantifiers.
  # rule(:all)        { str('all') >> space? }
  # rule(:exists)     { str('exists') >> space?}
  # 
  # # Operator Rules.
  # rule(:op)
  # rule(:op_not)        { str('!') >> space? }
  # rule(:op_equals)     { str('=') >> space? }
  # rule(:op_and)        { str('&') >> space? }
  # rule(:op_or)         { str('|') >> space? }
  # rule(:op_implies)    { str('=>') >> space? }
  # rule(:op_iif)        { str('<=>') >> space? }
  # 
  # # Character Rules.
  # rule(:lparen)     { str('(') >> space? }
  # rule(:rparen)     { str(')') >> space? }
  # rule(:comma)      { str(',') >> space? }
  # 

  root :sentence
  
  # Sentenct - a sentence is an AtomicSentence or a ComplexSentenct.
  rule(:sentence)         { atomic_sentence | complex_sentence }
  
  # AtomicSentence - can be True, False or a Symbol.
  rule(:atomic_sentence)  { true_rule | false_rule | symbol }
  
  # ComplexSentence - can be a sentence surrounded by parentheses, or sentences operated on by logical operations.
  rule(:complex_sentence) { 
    lparen >> sentence >> rparen          |
    not_rule >> sentence                  |
    sentence >> and_rule >> sentence      |
    sentence >> or_rule >> sentence       |
    sentence >> implies_rule >> sentence  |
    sentence >> iif_rule >> sentence
  }
  
  # True and False constants. These are similar to keywords.
  rule(:true_rule)        { str('True').as(:true) >> space? }
  rule(:false_rule)       { str('False').as(:false) >> space? }
  
  # These are the operators: not, and, or, implies, and iif.
  rule(:not_rule)         { str('!').as(:not) >> space? }
  rule(:and_rule)         { str('&').as(:and) >> space? }
  rule(:or_rule)          { str('|').as(:or) >> space? }
  rule(:implies_rule)     { str('->').as(:implies) >> space? }
  rule(:iif_rule)         { str('<->').as(:iif) >> space? }

  # Sentences can be grouped with parentheses
  rule(:lparen)           { str('(').as(:lparen) >> space? }
  rule(:rparen)           { str(')').as(:rparen) >> space? }
  
  # Symbols - a symbol starts with an upper case character and is followed by characters and digits.
  rule(:symbol) { (match('[A-Z]') >> match('[A-Za-z0-9]').repeat).as(:symbol) >> space? }

  # Match whitespace.
  rule(:space)      { match('\s').repeat(1) }
  rule(:space?)     { space.maybe }
end

def parse(str)
  logic = Logic.new

  logic.parse(str)
rescue Parslet::ParseFailed => failure
  puts failure.cause.ascii_tree
end
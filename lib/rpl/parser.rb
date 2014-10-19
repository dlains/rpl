require 'parslet'

class Rpl::Parser < Parslet::Parser
  # Match whitespace.
  rule(:space)            { match('\s').repeat(1) }
  rule(:space?)           { space.maybe }

  # Sentences can be grouped with parentheses
  rule(:lparen)           { str('(') >> space? }
  rule(:rparen)           { str(')') >> space? }

  # True and False constants. These are similar to keywords.
  rule(:true_const)       { str('True').as(:true) >> space? }
  rule(:false_const)      { str('False').as(:false) >> space? }

  # Symbols - a symbol starts with an upper case character and is followed by characters and digits.
  rule(:symbol) { (match('[A-Z]') >> match('[A-Za-z0-9]').repeat).as(:symbol) >> space? }

  # These are the operators: not, and, or, implies, and iif.
  rule(:not_oper)         { str('not') >> space? }
  rule(:and_oper)         { str('and') >> space? }
  rule(:or_oper)          { str('or') >> space? }
  rule(:implies_oper)     { str('implies') >> space? }
  rule(:iif_oper)         { str('iif') >> space? }

  # Primary rule handles parentheses.
  rule(:primary)          { lparen >> iif_operation >> rparen | true_const | false_const | symbol  }
  
  # Note that following rules are right-recursive.
  rule(:not_operation) {
    (not_oper >>
      not_operation.as(:right)).as(:not) |
    primary }

  rule(:and_operation) {
    (not_operation.as(:left) >> and_oper >>
      and_operation.as(:right)).as(:and) |
    not_operation }

  rule(:or_operation) {
    (and_operation.as(:left) >> or_oper >>
      or_operation.as(:right)).as(:or) |
    and_operation }
    
  rule(:implies_operation) {
    (or_operation.as(:left) >> implies_oper >>
      implies_operation.as(:right)).as(:implies) |
    or_operation }

  rule(:iif_operation) {
    (implies_operation.as(:left) >> iif_oper >>
      iif_operation.as(:right)).as(:iif) |
    implies_operation }

  # Start at the lowest precendence rule.
  root :iif_operation

end

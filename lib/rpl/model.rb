module Rpl

  class Model

    attr_accessor :assignments

    def initialize(assignments = {})
      @assignments = assignments
    end

    def union(identifier, value)
      return Model.new(self.assignments.merge({identifier => value}))
    end

    def is_true?(sentence)
      return sentence.accept(self) == true
    end

    def is_false?(sentence)
      return sentence.accept(self) == false
    end

    def is_unknown?(sentence)
      return sentence.accept(self) == nil
    end

    def eval_identifier(sentence)
      return true if sentence.is_true_identifier?
      return false if sentence.is_false_identifier?
      return @assignments[sentence.identifier]
    end

    def eval_unary_sentence(sentence)
      negated_value = sentence.simple_sentence(0).accept(self)
      if negated_value != nil
        return !negated_value
      else
        return nil
      end
    end

    def eval_binary_sentence(sentence)
      first_val = sentence.simple_sentence(0).accept(self)
      second_val = sentence.simple_sentence(1).accept(self)
      
      return nil if first_val == nil && second_val == nil
      
      case sentence.operator
      when Sentence::OPERATOR_AND
        return first_val && second_val
      when Sentence::OPERATOR_OR
        return first_val || second_val
      when Sentence::OPERATOR_IMPLIES
        return !(first_val && !second_val)
      when Sentence::OPERATOR_IIF
        return first_val == second_val
      else
        return nil
      end
    end

  end

end
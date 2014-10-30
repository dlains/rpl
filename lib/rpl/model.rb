module Rpl

  class Model

    attr_accessor :assignments

    def initialize
      @assignments = {}
    end

    def is_true?(sentence)
      return sentence.accept(self) == true
    end

    def is_false?(sentence)
      return sentence.accept(self) == false
    end

    def visit_symbol(sentence)
      return true if sentence.is_true_literal?
      return false if sentence.is_false_literal?
      return @assignments[sentence[:symbol]]
    end

    def visit_unary_sentence(sentence)
    end

    def visit_binary_sentence(sentence)
    end

  end

end
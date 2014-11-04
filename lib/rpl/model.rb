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
    end
    # @Override
    # public Boolean visitBinarySentence(ComplexSentence bs, Boolean arg) {
    #   Boolean firstValue = (Boolean) bs.getSimplerSentence(0).accept(this,
    #       null);
    #   Boolean secondValue = (Boolean) bs.getSimplerSentence(1).accept(this,
    #       null);
    #   if ((firstValue == null) || (secondValue == null)) {
    #     // strictly not true for or/and
    #     // -FIX later
    #     return null;
    #   } else {
    #     Connective connective = bs.getConnective();
    #     if (connective.equals(Connective.AND)) {
    #       return firstValue && secondValue;
    #     } else if (connective.equals(Connective.OR)) {
    #       return firstValue || secondValue;
    #     } else if (connective.equals(Connective.IMPLICATION)) {
    #       return !(firstValue && !secondValue);
    #     } else if (connective.equals(Connective.BICONDITIONAL)) {
    #       return firstValue.equals(secondValue);
    #     }
    #     return null;
    #   }
    # }

  end

end
module Rpl

  class Sentence

    OPERATOR_NOT     = 'not'
    OPERATOR_AND     = 'and'
    OPERATOR_OR      = 'or'
    OPERATOR_IMPLIES = 'implies'
    OPERATOR_IIF     = 'iif'

    def operator
      return nil
    end

    def simple_sentence_count
      return 0
    end

    def simple_sentence(index)
      return nil
    end

    def is_not_sentence?
      return has_operator?(OPERATOR_NOT)
    end

    def is_and_sentence?
      return has_operator?(OPERATOR_AND)
    end

    def is_or_sentence?
      return has_operator?(OPERATOR_OR)
    end

    def is_implies_sentence?
      return has_operator?(OPERATOR_IMPLIES)
    end

    def is_iif_sentence?
      return has_operator?(OPERATOR_IIF)
    end

    def is_identifier?
      return operator == nil
    end

    def is_true_identifier?
      raise NotImplementedError
    end

    def is_false_identifier?
      raise NotImplementedError
    end

    def is_unary_sentence?
      return has_operator?(OPERATOR_NOT)
    end
    
    def is_binary_sentence?
      return operator != nil && !has_operator?(OPERATOR_NOT)
    end

    def accept(model)
      result = nil
      if is_identifier?
        result = model.eval_identifier(self)
      elsif is_unary_sentence?
        result = model.eval_unary_sentence(self)
      elsif is_binary_sentence?
        result = model.eval_binary_sentence(self)
      end
      
      return result
    end

    def identifiers
      return find_identifiers(@sentence)
    end

    def to_s
      "#{@original_sentence}"
    end

    private

    def has_operator?(operator)
      return self.operator == operator
    end

    # def find_symbols(hash)
    #   symbols = []
    #   hash.each do |k,v|
    #     v.is_a?(Hash) ? symbols << find_symbols(v) : (symbols << v.to_s if k == :symbol)
    #   end
    #   return symbols.flatten
    # end

  end

end

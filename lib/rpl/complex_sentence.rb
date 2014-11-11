module Rpl

  class ComplexSentence < Sentence
    
    attr_accessor :simple_sentences
    
    def initialize(operator, *sentences)
      @operator = operator
      @simple_sentences = sentences
    end

    def operator
      return @operator
    end

    def simple_sentence_count
      return @simple_sentences.size
    end

    def simple_sentence(index)
      return @simple_sentences[index]
    end

    def ==(other)
      return true if other.equal?(self)
      return false unless other.instance_of?(self.class)
      return false unless other.operator == self.operator
      return false unless other.simple_sentence_count == self.simple_sentence_count
      result = true
      self.simple_sentence_count.times do |x|
        result = false unless self.simple_sentence(x) == other.simple_sentence(x)
      end
      
      return result
    end

    def to_s
      return build_unary_sentence_string if is_unary_sentence?
      return build_binary_sentence_string if is_binary_sentence?
    end

    private

    def build_unary_sentence_string
      return "#{operator} #{sentence_with_parens(operator, simple_sentence(0))}"
    end

    def build_binary_sentence_string
      return "#{sentence_with_parens(operator, simple_sentence(0))} #{operator} #{sentence_with_parens(operator, simple_sentence(1))}"
    end

    def sentence_with_parens(parent_operator, sentence)
      if sentence.is_a?(ComplexSentence)
        if higher_precedence?(parent_operator, sentence.operator)
          return "(#{sentence.to_s})"
        end
      end
      return sentence.to_s
    end

    def higher_precedence?(parent_operator, child_operator)
      return OPERATOR_PRECEDENCE[parent_operator] > OPERATOR_PRECEDENCE[child_operator]
    end

  end

end

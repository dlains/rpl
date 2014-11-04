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
  end

end

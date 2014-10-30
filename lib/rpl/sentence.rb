module Rpl

  class Sentence
    attr_accessor :original_sentence, :sentence

    def initialize(sentence)
      @original_sentence = sentence
      @sentence = Parser.new.parse(sentence)
    end

    def accept(model)
      result = nil
      if is_symbol?
        result = model.visit_symbol(self)
      elsif is_unary_sentence?
        result = model.visit_unary_sentence(self)
      elsif is_binary_sentence?
        result = model.visit_binary_sentence(self)
      end
      
      return result
    end

    def symbols
      return find_symbols(@sentence)
    end

    def to_s
      "#{@original_sentence}"
    end

    def is_symbol?
      return @sentence.has_key?(:symbol) || @sentence.has_key?(:true) || @sentence.has_key?(:false)
    end

    def is_unary_sentence?
      return @sentence.has_key?(:not)
    end
    
    def is_binary_sentence?
      return @sentence.has_key?(:iif) || @sentence.has_key?(:implies) || @sentence.has_key?(:or) || @sentence.has_key?(:and)
    end

    def is_true_literal?
      return @sentence.has_key?(:true)
    end

    def is_false_literal?
      return @sentence.has_key?(:false)
    end

    private

    def find_symbols(hash)
      symbols = []
      hash.each do |k,v|
        v.is_a?(Hash) ? symbols << find_symbols(v) : (symbols << v.to_s if k == :symbol)
      end
      return symbols.flatten
    end

  end

end

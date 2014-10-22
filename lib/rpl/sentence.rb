module Rpl

  class Sentence
    attr_accessor :original_sentence, :parsed_sentence

    def initialize(sentence)
      @original_sentence = sentence
      @parsed_sentence = Parser.new.parse(sentence)
    end

    def symbols
      return find_symbols(@parsed_sentence)
    end

    def to_s
      "#{@original_sentence}"
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

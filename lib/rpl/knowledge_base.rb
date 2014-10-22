module Rpl
  
  class KnowledgeBase

    attr_accessor :sentences

    def initialize()
      @sentences = []
      @query = nil
    end
    
    def tell(sentence)
      @sentences << Sentence.new(sentence)
    end

    def ask(query)
      @query = Sentence.new(query)
    end

    def symbols
      result = []
      @sentences.each do |sentence|
        result << sentence.symbols
      end
      result << @query.symbols
      
      return result
    end

  end

end

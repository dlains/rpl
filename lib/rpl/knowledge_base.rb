module Rpl
  
  class KnowledgeBase

    attr_accessor :sentences

    def initialize()
      @sentences = []
    end
    
    def tell(sentence)
      @sentences << Sentence.new(sentence)
    end

  end

end

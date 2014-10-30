module Rpl
  
  class KnowledgeBase

    attr_accessor :sentences

    def initialize()
      @sentences = []
    end
    
    def tell(sentence)
      @sentences << Sentence.new(sentence)
    end

    def ask(query)
      alpha = Sentence.new(query)
      return Inference::Entails.entails?(self, alpha)
    end

    def as_sentence
      return nil if @sentences.empty?
      return @sentences.shift.sentence if @sentences.size == 1
      full_sentence = @sentences.pop.sentence
      @sentences.reverse_each do |sentence|
        full_sentence = {and: {left: sentence.sentence, right: full_sentence}}
      end
      return full_sentence
    end
  end

end

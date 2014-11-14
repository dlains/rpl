module Rpl
  
  class KnowledgeBase

    attr_accessor :sentences

    def initialize()
      @sentences = []
    end
    
    def tell(*sentences)
      sentences.each do |sentence|
        parsed = Transformer.new.apply(Parser.new.parse(sentence))
        @sentences << parsed unless @sentences.include?(parsed)
      end
    end

    def ask(query)
      alpha = Transformer.new.apply(Parser.new.parse(query))
      return Inference::Entails.new.entails?(self, alpha)
    end

    def as_sentence
      return nil if @sentences.empty?
      return @sentences.first if @sentences.size == 1
      sentences = @sentences.dup
      full_sentence = sentences.pop
      sentences.reverse_each do |sentence|
        full_sentence = ComplexSentence.new(Sentence::OPERATOR_AND, sentence, full_sentence)
      end
      return full_sentence
    end

    def to_s
      return "#{sentences.join("\n")}"
    end

    def store
      data_store = Data::DataStore.create(Rpl.configuration.data_store)
      data_store.store
    end

    def load
      data_store = Data::DataStore.create(Rpl.configuration.data_store)
      data_store.load
    end

  end

end

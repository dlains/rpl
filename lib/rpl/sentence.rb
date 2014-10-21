module Rpl

  class Sentence
    attr_accessor :original_sentence, :parsed_sentence

    def initialize(sentence)
      @original_sentence = sentence
      @parsed_sentence = Parser.new.parse(sentence)
    end

  end

end

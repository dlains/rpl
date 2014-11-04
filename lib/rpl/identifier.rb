module Rpl

  class Identifier < Sentence

    TRUE_SYMBOL = 'True'
    FALSE_SYMBOL = 'False'

    attr_reader :identifier

    def initialize(identifier)
      @identifier = identifier
    end

    def is_true_identifier?
      return @identifier == TRUE_SYMBOL
    end

    def is_false_identifier?
      return @identifier == FALSE_SYMBOL
    end

    def ==(other)
      return self.identifier == other if other.class == String
      return self.class == other.class && self.identifier == other.identifier
    end
    alias_method :eql?, :==

    def hash
      return self.identifier.hash
    end
    
    def to_s
      return self.identifier.to_s
    end
  end

end

module Rpl
  class Tell
    
    attr_accessor :global_options, :options, :args
    
    def initialize(global_options, options, args)
      @args = args
      @options = options
      @kb = KnowledgeBase.new(global_options)
    end
    
    def tell
      @kb.tell(@options[:name], @args)
    end
  end
end

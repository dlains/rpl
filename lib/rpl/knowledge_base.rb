module Rpl
  
  class KnowledgeBase
    
    def initialize(global_options)
      @data = Data::DataStore.create(global_options)
    end
    
    def tell(kb_name, sentence)
      @data.add_sentence(kb_name, sentence)
    end

  end

end

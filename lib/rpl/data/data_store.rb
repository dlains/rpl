module Rpl::Data

  class DataStore
    
    def self.create(options)
      # if options.has_key?(:db) || options.has_key?(:db_data_store)
      #   # Database Data Store is not implemented yet.
      #   raise NotImplementedError
      # end
      
      puts "About to create new file data store with path: #{options[:f]}"
      return FileDataStore.new(options[:f])
    end

    def add_sentence(kb_name, sentence)
      raise NotImplementedError
    end
    
    def load_sentences(kb_name)
      raise NotImplementedError
    end

  end

end

module Rpl::Data

  class DataStore
    
    def self.create(type)
      case type
      when 'File'
        return FileDataStore.new
      when 'Database'
        return DatabaseDataStore.new
      else
        raise InvalidArgumentError
      end
    end

    def store(kb)
      raise NotImplementedError
    end
    
    def load
      raise NotImplementedError
    end

  end

end

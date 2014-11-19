module Rpl::Data

  class DataStore
    
    def self.create(type)
      case type
      when 'File'
        return FileDataStore.new(File.join(Rpl.configuration.file_path, Rpl.configuration.file_name))
      when 'Database'
        return DatabaseDataStore.new
      else
        raise InvalidArgumentError
      end
    end

    def save(kb)
      raise NotImplementedError
    end
    
    def load(kb)
      raise NotImplementedError
    end

  end

end

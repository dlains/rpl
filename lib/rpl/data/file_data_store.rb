module Rpl::Data

  class FileDataStore < DataStore

    def initialize(file_path)
      create_directory(file_path)
      @data_store = File.open(file_path, 'a+')
    end

    def add_sentence(kb_name, sentence)
      puts "Adding sentence #{sentence} to knowledge base #{kb_name}"
    end
    
    def load_sentences(kb_name)
      puts "Reading sentences from knowledge base #{kb_name}"
    end

    private
    
    def create_directory(file_path)
      FileUtils.mkdir_p(File.dirname(file_path)) unless File.directory?(File.dirname(file_path))
    end
  end

end
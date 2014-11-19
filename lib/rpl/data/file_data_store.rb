module Rpl::Data

  class FileDataStore < DataStore

    def initialize(file_path)
      @file_path = file_path
    end

    def save(kb)
      raise ArgumentError unless kb.is_a?(Rpl::KnowledgeBase)
      create_directory
      File.open(@file_path, 'a+') do |file|
        file.write(kb.to_s)
      end
    end
    
    def load(kb)
      raise ArgumentError unless kb.is_a?(Rpl::KnowledgeBase)
      File.open(@file_path, 'r') do |file|
        file.each_line do |line|
          kb.tell(line)
        end
      end
    end

    private
    
    def create_directory
      FileUtils.mkdir_p(File.dirname(@file_path)) unless File.directory?(File.dirname(@file_path))
    end
  end

end
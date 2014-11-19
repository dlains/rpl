module Rpl

  class Configuration
    attr_accessor :data_store
    attr_accessor :file_path
    attr_accessor :file_name

    def initialize
      @data_store = 'File'
      @file_path  = Dir.home
      @file_name  = '.rpl_data'
    end
  end

end

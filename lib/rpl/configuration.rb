module Rpl

  class Configuration
    attr_accessor :data_store

    def initialize
      @data_store = 'File'
    end
  end

end

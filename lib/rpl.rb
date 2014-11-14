require 'rpl/data/data_store'
require 'rpl/data/file_data_store'
require 'rpl/sentence'
require 'rpl/complex_sentence'
require 'rpl/identifier'
require 'rpl/configuration'
require 'rpl/knowledge_base'
require 'rpl/model'
require 'rpl/parser'
require 'rpl/transformer'
require 'rpl/version'
require 'rpl/inference/entails'

module Rpl
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
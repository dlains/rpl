require 'simplecov'
SimpleCov.start

require 'byebug'
require_relative '../lib/rpl'

RSpec.configure do |config|
  config.color = true
end

def build_sentence(string)
  return Rpl::Transformer.new.apply(Rpl::Parser.new.parse(string))
end

require 'simplecov'
SimpleCov.start

require 'byebug'
require_relative '../lib/rpl'

RSpec.configure do |config|
  config.color = true
end

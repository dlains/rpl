require 'simplecov'
SimpleCov.start

require 'rpl'
require 'byebug'

RSpec.configure do |config|
  config.color = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  # --seed 1234
  config.order = 'random'
end

def build_sentence(string)
  return Rpl::Transformer.new.apply(Rpl::Parser.new.parse(string))
end

def data_dir
  "#{File.dirname(__FILE__)}/data/"
end
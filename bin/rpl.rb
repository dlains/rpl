#!/usr/bin/env ruby
begin # XXX: Remove this begin/rescue before distributing your app
require 'rpl'
rescue LoadError
  STDERR.puts "In development, you need to use `bundle exec bin/stoker` to run your app"
  STDERR.puts "At install-time, RubyGems will make sure lib, etc. are in the load path"
  STDERR.puts "Feel free to remove this message from bin/stoker now"
  exit 64
end

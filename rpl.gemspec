# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','rpl','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'rpl'
  s.version = Rpl::VERSION
  s.license = 'MIT'
  s.author = 'David Lains'
  s.email = 'me@davidlains.com'
  s.homepage = 'http://davidlains.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'RPL: Ruby Propositional Logic.'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','rpl.rdoc']
  s.rdoc_options << '--title' << 'rpl' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'rpl'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('rspec')
  s.add_development_dependency('simplecov')
  s.add_runtime_dependency('parslet')
  s.add_runtime_dependency('gli')
end

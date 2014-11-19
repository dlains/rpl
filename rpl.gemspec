# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rpl/version'

Gem::Specification.new do |s|
  s.name             = 'rpl'
  s.version          = Rpl::VERSION
  s.author           = 'David Lains'
  s.email            = 'me@davidlains.com'
  s.description      = 'Propositional Logic inference algorithms and knowledge base.'
  s.summary          = 'RPL: Ruby Propositional Logic.'
  s.homepage         = 'http://davidlains.com'
  s.license          = 'MIT'
  s.platform         = Gem::Platform::RUBY

  s.files            = `git ls-files`.split($/)
  s.test_files       = s.files.grep(%r{^(test|spec||features)/})
  s.require_paths    = ['lib']

  s.has_rdoc         = true
  s.extra_rdoc_files = ['README.rdoc','rpl.rdoc']
  s.rdoc_options     << '--title' << 'rpl' << '--main' << 'README.rdoc' << '-ri'

  s.add_development_dependency('bundler', '~> 1.3')
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('rspec')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('byebug')
  s.add_runtime_dependency('parslet')
end

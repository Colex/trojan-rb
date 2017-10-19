# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name          = 'trojan'
  s.version       = '0.0.0'
  s.date          = '2001-01-01'
  s.summary       = 'Library of spies, stubs and mocks for Ruby'
  s.description   = 'Library of spies, stubs and mocks for Ruby'
  s.homepage      = 'https://github.com/Colex/trojan-rb'
  s.authors       = ['Alex Correia Santos']
  s.email         = ['hello@alexcsantos.com']
  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.require_paths = ['lib']
  s.license       = 'MIT'

  s.required_ruby_version = '>= 2.2.2'

  s.add_development_dependency 'bundler', '~> 1.12'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'rake', '~> 11.3'
  s.add_development_dependency 'rubocop', '~> 0.45.0'
  s.add_development_dependency 'byebug'
end

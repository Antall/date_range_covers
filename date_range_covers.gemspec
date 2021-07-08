# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date_range_covers/version'

Gem::Specification.new do |spec|
  spec.name          = 'date_range_covers'
  spec.version       = DateRangeCovers::VERSION
  spec.authors       = ['Antall Fernandes']
  spec.email         = ['antallfernandes@gmail.com']
  spec.description   = 'The gem helps find the years, months, weeks and days covered by a date range'
  spec.summary       = ''
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.5', '< 3'

  spec.add_development_dependency 'activesupport', '~> 6.1'
  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
end

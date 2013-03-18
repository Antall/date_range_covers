# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date_range_covers/version'

Gem::Specification.new do |spec|
  spec.name          = "date_range_covers"
  spec.version       = DateRangeCovers::VERSION
  spec.authors       = ["Antall Fernandes"]
  spec.email         = ["antallfernandes@gmail.com"]
  spec.description   = %q{The gem helps find the years, months, weeks and days covered by a date range}
  spec.summary       = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rails", "~> 2.3"
end

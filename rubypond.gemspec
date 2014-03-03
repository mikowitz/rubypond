# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubypond/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubypond'
  spec.version       = Rubypond::VERSION
  spec.authors       = ['Michael Berkowitz']
  spec.email         = ['michael.berkowitz@gmail.com']
  spec.description   = %q{Write music with Ruby!}
  spec.summary       = %q{Write music with Ruby!}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
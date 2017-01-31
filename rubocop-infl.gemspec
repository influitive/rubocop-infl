# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubocop/infl/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-infl'
  spec.version       = Rubocop::Infl::VERSION
  spec.authors       = ['Mike Stok']
  spec.email         = ['mike.stok@influitive.com']

  spec.summary       = 'A package of Influitive cop(s) for Rubocop.'
  spec.homepage      = 'https://github.com/influitive/rubocop-infl'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rubocop', '>= 0.37.1'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'

  spec.add_development_dependency 'pry'
end

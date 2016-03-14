# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'commonsense/version'

Gem::Specification.new do |spec|
  spec.name          = "commonsense"
  spec.version       = Commonsense::VERSION
  spec.authors       = ["Ben Eills"]
  spec.email         = ["ben@beneills.com"]

  spec.summary       = %q{Validate text against the commonsense spec to resist authorship analysis.}
  spec.homepage      = "https://github.com/beneills/commonsense-gem"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end

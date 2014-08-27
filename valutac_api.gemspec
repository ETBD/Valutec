# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'valutac_api/version'

Gem::Specification.new do |spec|
  spec.name          = "valutac_api"
  spec.version       = ValutacApi::VERSION
  spec.authors       = ["Nikky Southerland"]
  spec.email         = ["nikky@ricksteves.com"]
  spec.summary       = %q{Provides a wrapper to the Valutec Gift Card API}
  spec.description   = %q{This gem provides a lightweight interface to the Valutec Gift Card HTTP GET API. Additionally supports reporting functionality.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_dependency "httparty"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'web_font/version'

Gem::Specification.new do |spec|
  spec.name          = "web_font"
  spec.version       = WebFont::VERSION
  spec.authors       = ["Sophy Eung"]
  spec.email         = ["ungsophy@gmail.com"]
  spec.description   = 'Download web fonts'
  spec.summary       = 'Download web fonts'
  spec.homepage      = "https://github.com/ungsophy/web_font"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'minitest', '~> 5.2.0'
end

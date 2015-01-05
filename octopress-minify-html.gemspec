# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octopress-minify-html/version'

Gem::Specification.new do |spec|
  spec.name          = "octopress-minify-html"
  spec.version       = Octopress::MinifyHTML::VERSION
  spec.authors       = ["Brandon Mathis"]
  spec.email         = ["brandon@imathis.com"]
  spec.description   = %q{Minify Jekyll's HTML output using html_press}
  spec.summary       = %q{Minify Jekyll's HTML output using html_press}
  spec.homepage      = "https://github.com/octopress/minify-html"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n").grep(%r{^(bin\/|lib\/|assets\/|changelog|readme|license)}i)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "clash"

  spec.add_runtime_dependency "jekyll", "~> 2.0"
  spec.add_runtime_dependency "html_press", "~> 0.8"
end

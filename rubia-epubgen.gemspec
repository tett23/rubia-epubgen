# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rubia-epubgen/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["tett23"]
  gem.email         = ["tett23@gmail.com"]
  gem.description   = %q{epub generator}
  gem.summary       = %q{epub generator}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rubia-epubgen"
  gem.require_paths = ["lib"]
  gem.version       = Rubia::Epubgen::VERSION

  gem.add_dependency 'zipruby'
end

# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/celluloid/version'

Gem::Specification.new do |gem|
  gem.name          = "rspec-celluloid"
  gem.version       = Rspec::Celluloid::VERSION
  gem.authors       = ["Michael Fairley"]
  gem.email         = ["michaelfairley@gmail.com"]
  gem.description   = %q{Run your RSpec suite in parallel on top of Celluloid}
  gem.summary       = %q{Run your RSpec suite in parallel on top of Celluloid}
  gem.homepage      = "https://github.com/michaelfairley/rspec-celluloid"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("celluloid")
  gem.add_dependency("rspec-core")
  gem.add_development_dependency("rspec")
end

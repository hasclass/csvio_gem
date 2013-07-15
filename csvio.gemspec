# -*- encoding: utf-8 -*-
$LOAD_PATH.push(File.expand_path "../lib", __FILE__)
require "csvio/version"

Gem::Specification.new do |gem|
  gem.name          = "csvio"
  gem.authors       = ["Sebastian Burkhard"]
  gem.email         = ["sebi.burkhard@gmail.com"]
  gem.description   = %q{Provides a simple ruby wrapper around the Csvio API}
  gem.summary       = %q{Provides a simple ruby wrapper around the Csvio API}
  gem.homepage      = "http://csv.io"
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
  gem.version       = Csvio::VERSION

  gem.add_dependency "httmultiparty", ">=0.3.10"

  gem.add_development_dependency "minitest"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "webmock"
end

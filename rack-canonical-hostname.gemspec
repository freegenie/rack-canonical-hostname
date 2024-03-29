# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rack/canonical_host', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Fabrizio Regini", "Daniel Vartanov"]
  gem.email         = ["freegenie@gmail.com", "dan@vartanov.net"]
  gem.description   = %q{Handle redirect to canonical host}
  gem.summary       = %q{Rack module to redirect to one canonical host and redirect when hitting the app with any other name}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rack-canonical-hostname"
  gem.require_paths = ["lib"]
  gem.version       = Rack::CanonicalHost::VERSION
  gem.add_development_dependency 'rspec', '~> 2.0'
  gem.add_development_dependency 'rack'
end

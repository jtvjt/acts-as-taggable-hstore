$:.push File.dirname(__FILE__) + '/lib'
require 'acts-as-taggable-hstore/version'

Gem::Specification.new do |gem|
  gem.name = %q{acts-as-taggable-hstore}
  gem.authors = ["Jt Gleason"]
  gem.date = %q{2012-02-29}
  gem.description = %q{With ActsAsTaggableHstore, you can tag a single model that uses postgres hstore type}
  gem.summary = "Basic postgres hstore tagging for Rails."
  gem.email = %q{jt@twitch.tv}
  gem.homepage      = ''

  gem.add_runtime_dependency 'rails', '~> 3.0'
  gem.add_runtime_dependency 'activerecord-postgres-hstore-core', "~> 0.0.4"
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'ammeter', '~> 0.1.3'
  gem.add_development_dependency 'pg'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'


  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "acts-as-taggable-hstore"
  gem.require_paths = ['lib']
  gem.version       = ActsAsTaggableHstore::VERSION
end

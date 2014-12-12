Gem::Specification.new do |s|
  s.name = "endure"
  s.version = "0.1.0"

  s.authors =    ["Brian D Quinn"]
  s.description = "Object dual persistence & retrival engine, that uses key/value and search systems"
  s.summary =     "Object dual persistence & retrival engine, that uses key/value and search systems"
  s.email =       "briandquinn@gmail.com"
  s.extra_rdoc_files = [ "README.markdown" ]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.homepage = "https://github.com/bdq/endure"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]

  # sequel doesn't actually include any of the underlying db gems
  # so we can leave it as hard dependency
  #
  s.add_dependency 'sequel', '~> 4.17.0'

  #these database specific dependencies should be dropped
  #just here for now to make things easy to deal with.
  #users will need to include relevant lib in their Gemfile
  s.add_dependency 'aws-sdk-core', '~> 2.0.0'
  s.add_dependency 'sqlite3', '~> 1.3.0'

  s.add_development_dependency('rspec', '>= 3.1.0')
  s.add_development_dependency('simplecov', '>= 0.9.1')
end

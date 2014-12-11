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

  s.add_dependency 'aws-sdk-core', '~> 2.0.0'

  s.add_development_dependency('rspec', '>= 3.1.0')
  s.add_development_dependency('simplecov', '>= 0.9.1')
end

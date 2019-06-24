# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'summer_project/version'

Gem::Specification.new do |gem|
  gem.name          = "sp_client"
  gem.version       = SummerProject::VERSION
  gem.authors       = ["Kenneth John Balgos"]
  gem.email         = ["kennethjohnbalgos@gmail.com"]
  gem.description   = %q{This gem wraps an API for the Summer Project.}
  gem.summary       = %q{Push and pull data from the Summer Project}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('rest-client', '>= 1.8')
  gem.add_dependency('oj', '>= 2.18')
  gem.add_dependency('activesupport')
  gem.add_dependency('retryable-rb', '~> 1.1.0')

end

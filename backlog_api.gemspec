# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'backlog_api/version'

Gem::Specification.new do |spec|
  spec.name          = "backlog_api"
  spec.version       = BacklogApi::VERSION
  spec.authors       = ["a1125ts"]
  spec.email         = ["a1125ts@aiit.ac.jp"]
  spec.description   = %q{backlogのバックログを叩くよ}
  spec.summary       = %q{backlogのバックログを叩くよ。まずはチケットを作れるようにしたよ。}
  spec.homepage      = "https://github.com/a1125ts/backlog_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  # debug tools
  spec.add_development_dependency "pry"
  spec.add_development_dependency 'pry-doc'
  spec.add_development_dependency 'pry-debugger'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'tapp'

	spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "activesupport"
	
end

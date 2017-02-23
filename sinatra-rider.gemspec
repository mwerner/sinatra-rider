# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/rider/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-rider"
  spec.version       = Sinatra::Rider::VERSION
  spec.authors       = ["Matthew Werner"]
  spec.email         = ["m@mjw.io"]

  spec.summary       = %q{Sinatra's Rider}
  spec.description   = %q{All the extras that Sinatra prefers while performing}
  spec.homepage      = "https://github.com/mwerner/sinatra-rider"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'thin'
  spec.add_dependency 'thor'
  spec.add_dependency 'pg'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'sinatra',              '~> 1.4'
  spec.add_dependency 'sinatra-contrib',      '~> 1.4'
  spec.add_dependency 'sinatra-activerecord', '~> 2.0'
  spec.add_dependency 'sinatra_warden',       '~> 1.0'
  spec.add_dependency 'activerecord',         '~> 4.2'
  spec.add_dependency 'sprockets',            '~> 3.7'
  spec.add_dependency 'sass',                 '~> 3.4'
  spec.add_dependency 'uglifier'
  spec.add_dependency 'better_errors'
  spec.add_dependency 'binding_of_caller'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

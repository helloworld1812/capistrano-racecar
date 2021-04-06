# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/tasks/version'

Gem::Specification.new do |spec|
  spec.name = 'capistrano-racecar'
  spec.version = Capistrano::RacecarVERSION
  spec.authors = ['ZengTao']
  spec.email = ['so.zengtao@gmail.com']
  spec.summary = %q{Racecar integration for Capistrano}
  spec.description = %q{Racecar integration for Capistrano}
  spec.homepage = 'https://github.com/helloworld/capistrano-racecar'
  spec.license = 'LGPL-3.0'

  spec.required_ruby_version     = '>= 2.0.0'
  spec.files = `git ls-files`.split($/)
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '>= 3.9.0'
  spec.add_dependency 'capistrano-bundler'

  spec.add_development_dependency 'pry'
end

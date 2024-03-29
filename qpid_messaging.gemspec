# -*- encoding: utf-8 -*-
lib = File.expand_path('lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "qpid_messaging"
  s.version     = "0.20.2"
  s.platform    = Gem::Platform::RUBY
  s.authors     = "Apache Qpid Project"
  s.email       = "dev@qpid.apache.org"
  s.homepage    = "http://qpid.apache.org"
  s.summary     = "Qpid is an enterprise messaging framework."
  s.description = s.summary

  s.extensions   = "ext/cqpid/extconf.rb"
  s.files        = Dir["LICENSE",
                   "ChangeLog",
                   "README.rdoc",
                   "TODO",
                   "lib/**/*.rb",
                   "ext/**/*",
                   "examples/**/*.rb"
                ]
  s.require_path = 'lib'
end

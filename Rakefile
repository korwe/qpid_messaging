# Rakefile for Qpid -*- ruby -*-
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

task :noop

$:.push File.expand_path("../lib", __FILE__)

OUTPUT_DIR=ENV["OUTPUT_DIR"] || "."

require "rubygems"
require "rubygems/package_task"

require "rake/clean"
require "rake/extensiontask"
require "rdoc/task"
require "rake/testtask"

require "cucumber/rake/task"
require "rspec/core/rake_task"

CLOBBER.include("pkg")

load "./lib/qpid_messaging/version.rb"

#-------------
# Gem Details.
#-------------

NAME     = "qpid_messaging"
# VERSION  = Qpid::VERSION
AUTHOR   = "Apache Qpid Project"
EMAIL    = "dev@qpid.apache.org"
HOMEPAGE = "http://qpid.apache.org"
SUMMARY  = "Qpid is an enterprise messaging framework."

desc "Default: run all tests."
task :default => :test

desc "Runs all tests."
task :test => :"test:all"

#---------------
# Testing tasks.
#---------------

namespace :test do

  desc "Run RSpec tests."
  RSpec::Core::RakeTask.new do |t|
    t.ruby_opts = ['-rtest/unit']
    t.rcov       = false
    t.rcov_opts  = [
                    '--exclude', 'lib\/qpid_messaging.rb,spec\/,lib\/ruby',
                   ]
  end

  desc "Run all tests (default)."
  task :all => [:spec, :features]

  Cucumber::Rake::Task.new(:features) do |t|
    t.libs          = ["lib", "ext/nonblockio"]
    t.cucumber_opts = "--format progress"
  end

end

#---------------------
# Documentation tasks.
#---------------------

Rake::RDocTask.new(:rdoc => "rdoc",
                   :clobber_rdoc => "rdoc:clean",
                   :rerdoc => "rdoc:force") do |rd|
  rd.main    = "README.rdoc"
  rd.options << "--all"
  rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  rd.title = "Qpid Messaging Documentation"
end

#-----------------
# Package the gem.
#-----------------

spec = Gem::Specification.new do |s|
  s.name             = NAME
  s.version          = Qpid::VERSION
  s.platform         = Gem::Platform::RUBY
  s.extra_rdoc_files = ["README.rdoc"]
  s.summary          = SUMMARY
  s.description      = s.summary
  s.author           = AUTHOR
  s.email            = EMAIL
  s.homepage         = HOMEPAGE

  s.extensions = FileList["ext/**/extconf.rb"]

  s.require_path    = "lib"
  # DEPRECATED s.autorequire     = NAME
  s.files           = FileList["LICENSE",
                               "README.rdoc",
                               "Rakefile",
                               "TODO",
                               "lib/**/*.rb",
                               "test/**/*.rb",
                               "examples/**/*.rb",
                               "ext/**/*",
                               "features/**/*",
                               "spec/**/*"]
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.package_dir = "#{OUTPUT_DIR}/pkg"
end

#------------------
# Build native code
#------------------

Rake::ExtensionTask.new("cqpid", spec)


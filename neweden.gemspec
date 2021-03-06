# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "neweden"
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Adams"]
  s.date = "2013-01-06"
  s.description = "Ruby library for accessing Eve Online API"
  s.email = "jasonmadams@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/hash_extensions.rb",
    "lib/neweden.rb",
    "lib/neweden/account.rb",
    "lib/neweden/api.rb",
    "lib/neweden/character.rb",
    "lib/neweden/connection.rb",
    "lib/neweden/corporation.rb",
    "lib/neweden/errors.rb",
    "lib/neweden/eve.rb",
    "lib/neweden/image.rb",
    "lib/neweden/map.rb",
    "lib/neweden/server.rb",
    "lib/string_extensions.rb",
    "neweden.gemspec",
    "test/.gitignore",
    "test/config/.keep",
    "test/helper.rb",
    "test/test_neweden.rb",
    "test/test_neweden_live.rb"
  ]
  s.homepage = "http://github.com/ealdent/neweden"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Ruby library for accessing Eve Online API"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<typhoeus>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<shoulda-context>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<awesome_print>, [">= 0"])
    else
      s.add_dependency(%q<typhoeus>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<shoulda-context>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<awesome_print>, [">= 0"])
    end
  else
    s.add_dependency(%q<typhoeus>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<shoulda-context>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<awesome_print>, [">= 0"])
  end
end


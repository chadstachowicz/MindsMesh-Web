# -*- encoding: utf-8 -*-
# stub: backbonejs-rails 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "backbonejs-rails"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrew Gertig"]
  s.date = "2013-07-08"
  s.description = "All it does it give you the files you need, nothing fancy. When installed it will require Backbone.js, Underscore.js, and json2.js"
  s.email = ["andrew.gertig@gmail.com"]
  s.homepage = "https://github.com/AndrewGertig/backbonejs-rails"
  s.require_paths = ["lib"]
  s.rubyforge_project = "backbonejs-rails"
  s.rubygems_version = "2.1.11"
  s.summary = "Provide files needed for using Backbone.js with Rails 3.1+"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thor>, ["~> 0.14"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<rails>, ["~> 3.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.8.7"])
    else
      s.add_dependency(%q<thor>, ["~> 0.14"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<rails>, ["~> 3.0"])
      s.add_dependency(%q<rake>, ["~> 0.8.7"])
    end
  else
    s.add_dependency(%q<thor>, ["~> 0.14"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<rails>, ["~> 3.0"])
    s.add_dependency(%q<rake>, ["~> 0.8.7"])
  end
end

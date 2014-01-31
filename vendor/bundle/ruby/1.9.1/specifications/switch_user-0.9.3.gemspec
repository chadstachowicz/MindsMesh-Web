# -*- encoding: utf-8 -*-
# stub: switch_user 0.9.3 ruby lib

Gem::Specification.new do |s|
  s.name = "switch_user"
  s.version = "0.9.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Huang", "Luke Cowell"]
  s.date = "2013-05-31"
  s.description = "Easily switch current user to speed up development"
  s.email = ["flyerhzm@gmail.com"]
  s.homepage = "http://rubygems.org/gems/switch_user"
  s.require_paths = ["lib"]
  s.rubyforge_project = "switch_user"
  s.rubygems_version = "2.1.11"
  s.summary = "Easily switch current user to speed up development"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<actionpack>, [">= 0"])
      s.add_development_dependency(%q<railties>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.11.0"])
      s.add_development_dependency(%q<tzinfo>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<actionpack>, [">= 0"])
      s.add_dependency(%q<railties>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.11.0"])
      s.add_dependency(%q<tzinfo>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<actionpack>, [">= 0"])
    s.add_dependency(%q<railties>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.11.0"])
    s.add_dependency(%q<tzinfo>, [">= 0"])
  end
end

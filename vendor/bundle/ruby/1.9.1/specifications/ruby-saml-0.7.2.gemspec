# -*- encoding: utf-8 -*-
# stub: ruby-saml 0.7.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-saml"
  s.version = "0.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["OneLogin LLC"]
  s.date = "2013-02-22"
  s.description = "SAML toolkit for Ruby on Rails"
  s.email = "support@onelogin.com"
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["LICENSE", "README.md"]
  s.homepage = "http://github.com/onelogin/ruby-saml"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "http://www.rubygems.org/gems/ruby-saml"
  s.rubygems_version = "2.1.11"
  s.summary = "SAML Ruby Tookit"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<canonix>, ["= 0.1.1"])
      s.add_runtime_dependency(%q<uuid>, ["~> 2.3"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<canonix>, ["= 0.1.1"])
      s.add_dependency(%q<uuid>, ["~> 2.3"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<canonix>, ["= 0.1.1"])
    s.add_dependency(%q<uuid>, ["~> 2.3"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end

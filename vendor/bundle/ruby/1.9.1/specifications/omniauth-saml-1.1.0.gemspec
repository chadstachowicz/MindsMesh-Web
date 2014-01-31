# -*- encoding: utf-8 -*-
# stub: omniauth-saml 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-saml"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Raecoo Cao", "Ryan Wilcox", "Rajiv Aaron Manglani", "Steven Anderson", "Nikos Dimitrakopoulos"]
  s.date = "2013-11-11"
  s.description = "A generic SAML strategy for OmniAuth."
  s.email = "rajiv@alum.mit.edu"
  s.homepage = "https://github.com/PracticallyGreen/omniauth-saml"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "A generic SAML strategy for OmniAuth."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth>, ["~> 1.1"])
      s.add_runtime_dependency(%q<ruby-saml>, ["~> 0.7.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.6"])
      s.add_development_dependency(%q<rack-test>, ["~> 0.6"])
    else
      s.add_dependency(%q<omniauth>, ["~> 1.1"])
      s.add_dependency(%q<ruby-saml>, ["~> 0.7.2"])
      s.add_dependency(%q<rspec>, ["~> 2.8"])
      s.add_dependency(%q<simplecov>, ["~> 0.6"])
      s.add_dependency(%q<rack-test>, ["~> 0.6"])
    end
  else
    s.add_dependency(%q<omniauth>, ["~> 1.1"])
    s.add_dependency(%q<ruby-saml>, ["~> 0.7.2"])
    s.add_dependency(%q<rspec>, ["~> 2.8"])
    s.add_dependency(%q<simplecov>, ["~> 0.6"])
    s.add_dependency(%q<rack-test>, ["~> 0.6"])
  end
end

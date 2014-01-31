# -*- encoding: utf-8 -*-
# stub: omniauth-wsfed 0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-wsfed"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Keith Beckman"]
  s.date = "2013-08-02"
  s.description = "OmniAuth WS-Federation strategy enabling integration with Windows Azure Access Control Service (ACS), Active Directory Federation Services (ADFS) 2.0, custom Identity Providers built with Windows Identity Foundation (WIF) or any other Identity Provider supporting the WS-Federation protocol."
  s.email = ["kbeckman.c4sc@gmail.com"]
  s.homepage = "https://github.com/kbeckman/omniauth-wsfed"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "A WS-Federation + WS-Trust strategy for OmniAuth."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth>, ["~> 1.1.0"])
      s.add_runtime_dependency(%q<xmlcanonicalizer>, ["= 0.1.1"])
      s.add_development_dependency(%q<rspec>, [">= 2.12.0"])
      s.add_development_dependency(%q<rake>, [">= 10.0.3"])
      s.add_development_dependency(%q<rack-test>, [">= 0.6.2"])
    else
      s.add_dependency(%q<omniauth>, ["~> 1.1.0"])
      s.add_dependency(%q<xmlcanonicalizer>, ["= 0.1.1"])
      s.add_dependency(%q<rspec>, [">= 2.12.0"])
      s.add_dependency(%q<rake>, [">= 10.0.3"])
      s.add_dependency(%q<rack-test>, [">= 0.6.2"])
    end
  else
    s.add_dependency(%q<omniauth>, ["~> 1.1.0"])
    s.add_dependency(%q<xmlcanonicalizer>, ["= 0.1.1"])
    s.add_dependency(%q<rspec>, [">= 2.12.0"])
    s.add_dependency(%q<rake>, [">= 10.0.3"])
    s.add_dependency(%q<rack-test>, [">= 0.6.2"])
  end
end

# -*- encoding: utf-8 -*-
# stub: rapns 3.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rapns"
  s.version = "3.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ian Leitch"]
  s.date = "2013-08-30"
  s.description = "Professional grade APNs and GCM for Ruby"
  s.email = ["port001@gmail.com"]
  s.executables = ["rapns"]
  s.files = ["bin/rapns"]
  s.homepage = "https://github.com/ileitch/rapns"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "Professional grade APNs and GCM for Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_runtime_dependency(%q<net-http-persistent>, [">= 0"])
    else
      s.add_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_dependency(%q<net-http-persistent>, [">= 0"])
    end
  else
    s.add_dependency(%q<multi_json>, ["~> 1.0"])
    s.add_dependency(%q<net-http-persistent>, [">= 0"])
  end
end

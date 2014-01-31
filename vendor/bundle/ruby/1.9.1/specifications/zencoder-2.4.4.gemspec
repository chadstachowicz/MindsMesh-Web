# -*- encoding: utf-8 -*-
# stub: zencoder 2.4.4 ruby lib

Gem::Specification.new do |s|
  s.name = "zencoder"
  s.version = "2.4.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nathan Sutton", "Brandon Arbini"]
  s.date = "2013-01-30"
  s.description = "Zencoder <http://zencoder.com> integration library."
  s.email = "info@zencoder.com"
  s.homepage = "http://github.com/zencoder/zencoder-rb"
  s.require_paths = ["lib"]
  s.rubyforge_project = "zencoder"
  s.rubygems_version = "2.1.11"
  s.summary = "Zencoder <http://zencoder.com> integration library."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
    else
      s.add_dependency(%q<multi_json>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
    end
  else
    s.add_dependency(%q<multi_json>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
  end
end

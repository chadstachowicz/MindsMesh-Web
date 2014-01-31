# -*- encoding: utf-8 -*-
# stub: versionist 1.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "versionist"
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Ploetz"]
  s.date = "2013-08-29"
  s.description = "A plugin for versioning Rails based RESTful APIs."
  s.homepage = "https://github.com/bploetz/versionist"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "versionist-1.2.1"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3"])
      s.add_runtime_dependency(%q<yard>, ["~> 0.7"])
    else
      s.add_dependency(%q<rails>, [">= 3"])
      s.add_dependency(%q<yard>, ["~> 0.7"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3"])
    s.add_dependency(%q<yard>, ["~> 0.7"])
  end
end

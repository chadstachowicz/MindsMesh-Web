# -*- encoding: utf-8 -*-
# stub: canonix 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "canonix"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brendon Muir"]
  s.date = "2011-06-16"
  s.description = "This is based on andrewferk's rewrite for Ruby 1.9 compatibility, but applies \n      relevance's fix to ensure proper canonicalisation. It is intended that this be the new official \n      Ruby Canonicaliser as the other project seems to be abandoned."
  s.email = "brendon@spike.net.nz"
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = ["LICENSE", "README.rdoc"]
  s.homepage = "http://github.com/brendon/canonix"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "XML Canonicalizer for Ruby >= 1.92"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end

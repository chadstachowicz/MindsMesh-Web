# -*- encoding: utf-8 -*-
# stub: smarter_csv 1.0.14 ruby lib

Gem::Specification.new do |s|
  s.name = "smarter_csv"
  s.version = "1.0.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tilo Sloboda\n"]
  s.date = "2013-11-02"
  s.description = "Ruby Gem for smarter importing of CSV Files as Array(s) of Hashes, with optional features for processing large files in parallel, embedded comments, unusual field- and record-separators, flexible mapping of CSV-headers to Hash-keys"
  s.email = ["tilo.sloboda@gmail.com\n"]
  s.homepage = "https://github.com/tilo/smarter_csv"
  s.licenses = ["MIT", "GPL-2"]
  s.require_paths = ["lib"]
  s.requirements = ["csv"]
  s.rubygems_version = "2.1.11"
  s.summary = "Ruby Gem for smarter importing of CSV Files (and CSV-like files), with lots of optional features, e.g. chunked processing for huge CSV files"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end

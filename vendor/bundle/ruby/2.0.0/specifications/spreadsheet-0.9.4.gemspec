# -*- encoding: utf-8 -*-
# stub: spreadsheet 0.9.4 ruby lib

Gem::Specification.new do |s|
  s.name = "spreadsheet"
  s.version = "0.9.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Masaomi Hatakeyama, Zeno R.R. Davatz"]
  s.date = "2013-11-12"
  s.description = ""
  s.email = ["mhatakeyama@ywesee.com, zdavatz@ywesee.com"]
  s.executables = ["xlsopcodes"]
  s.extra_rdoc_files = ["LICENSE.txt", "Manifest.txt"]
  s.files = ["bin/xlsopcodes", "LICENSE.txt", "Manifest.txt"]
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "spreadsheet"
  s.rubygems_version = "2.1.11"
  s.summary = ""

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-ole>, [">= 1.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<hoe>, ["~> 2.13"])
    else
      s.add_dependency(%q<ruby-ole>, [">= 1.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<hoe>, ["~> 2.13"])
    end
  else
    s.add_dependency(%q<ruby-ole>, [">= 1.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<hoe>, ["~> 2.13"])
  end
end
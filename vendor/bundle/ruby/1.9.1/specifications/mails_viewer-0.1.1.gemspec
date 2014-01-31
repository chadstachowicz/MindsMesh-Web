# -*- encoding: utf-8 -*-
# stub: mails_viewer 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "mails_viewer"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Youcai Qian", "Dingding Ye"]
  s.date = "2013-03-22"
  s.description = "A mails preview Engine which provides a table view for all mails under tmp/mails."
  s.email = ["qycpublic@gmail.com", "yedingding@gmail.com"]
  s.homepage = "https://github.com/pragmaticly/mails_viewer"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "A mails preview Engine which provides a table view for all mails under tmp/mails."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.1.0"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 2.0.1"])
      s.add_runtime_dependency(%q<jquery-datatables-rails>, [">= 0"])
      s.add_development_dependency(%q<mail>, ["~> 2.4.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.11.0"])
    else
      s.add_dependency(%q<rails>, [">= 3.1.0"])
      s.add_dependency(%q<jquery-rails>, [">= 2.0.1"])
      s.add_dependency(%q<jquery-datatables-rails>, [">= 0"])
      s.add_dependency(%q<mail>, ["~> 2.4.0"])
      s.add_dependency(%q<rspec>, ["~> 2.11.0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.1.0"])
    s.add_dependency(%q<jquery-rails>, [">= 2.0.1"])
    s.add_dependency(%q<jquery-datatables-rails>, [">= 0"])
    s.add_dependency(%q<mail>, ["~> 2.4.0"])
    s.add_dependency(%q<rspec>, ["~> 2.11.0"])
  end
end

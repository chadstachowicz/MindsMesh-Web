# -*- encoding: utf-8 -*-
# stub: validates_email_format_of 1.5.3 ruby lib

Gem::Specification.new do |s|
  s.name = "validates_email_format_of"
  s.version = "1.5.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Dunae"]
  s.date = "2011-10-12"
  s.description = "Validate e-mail addresses against RFC 2822 and RFC 3696."
  s.email = "code@dunae.ca"
  s.extra_rdoc_files = ["README.rdoc", "MIT-LICENSE"]
  s.files = ["README.rdoc", "MIT-LICENSE"]
  s.homepage = "https://github.com/alexdunae/validates_email_format_of"
  s.rdoc_options = ["--title", "validates_email_format_of"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "Validate e-mail addresses against RFC 2822 and RFC 3696."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<activerecord>, [">= 0"])
    else
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<activerecord>, [">= 0"])
    end
  else
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<activerecord>, [">= 0"])
  end
end

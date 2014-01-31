# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "template_rider/version"

Gem::Specification.new do |s|
  s.name        = "template_rider"
  s.version     = TemplateRider::VERSION
  s.authors     = ["Thiago Almeida"]
  s.email       = ["tapgyn@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{helps you override templates for several generators}
  s.description = %q{type 'rails generate', choose one and run it, open the generated files and it will all become clear}

  s.rubyforge_project = "template_rider"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end

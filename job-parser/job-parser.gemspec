# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "job-parser"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["蒼時弦也"]
  s.email       = ["elct9620@frost.tw"]
  # s.homepage    = "http://example.com"
  s.summary     = %q{The mokumokukai job data parser}
  # s.description = %q{A longer description of your extension}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 4.2.0"])
  s.add_runtime_dependency("redcarpet")

  # Additional dependencies
  # s.add_runtime_dependency("gem-name", "gem-version")
end

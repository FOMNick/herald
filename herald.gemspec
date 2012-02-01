# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'herald/version'

Gem::Specification.new do |s|
  s.name        = "herald"
  s.version     = Herald::VERSION
  s.authors     = ["Nick Watkins"]
  s.email       = ["nick@frontofficemedia.com"]
  s.homepage    = "https://github.com/FOMNick/herald"
  s.summary     = %q{Simple push notification alongside your normal controller actions!}
  s.description = %q{Utilizes Jose Valim's wonderful little "responders" gem to hook publisher classes into the render process.}

  s.rubyforge_project = "herald"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end

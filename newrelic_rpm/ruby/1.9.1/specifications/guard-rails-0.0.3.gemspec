# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "guard-rails"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Bintz"]
  s.date = "2011-08-04"
  s.description = "Restart Rails when things change in your app"
  s.email = ["john@coswellproductions.com"]
  s.homepage = ""
  s.require_paths = ["lib"]
  s.rubyforge_project = "guard-rails"
  s.rubygems_version = "1.8.10"
  s.summary = "Restart Rails when things change in your app"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guard>, [">= 0.2.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<guard>, [">= 0.2.2"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<guard>, [">= 0.2.2"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end

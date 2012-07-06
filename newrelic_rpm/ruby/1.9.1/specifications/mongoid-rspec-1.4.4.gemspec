# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mongoid-rspec"
  s.version = "1.4.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Evan Sagge"]
  s.date = "2011-06-02"
  s.description = "RSpec matches for Mongoid models, including association and validation matchers"
  s.email = "evansagge@gmail.com"
  s.homepage = "http://github.com/evansagge/mongoid-rspec"
  s.require_paths = ["lib"]
  s.rubyforge_project = "mongoid-rspec"
  s.rubygems_version = "1.8.10"
  s.summary = "RSpec matchers for Mongoid"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, ["~> 2.0"])
      s.add_runtime_dependency(%q<rspec>, ["~> 2"])
    else
      s.add_dependency(%q<mongoid>, ["~> 2.0"])
      s.add_dependency(%q<rspec>, ["~> 2"])
    end
  else
    s.add_dependency(%q<mongoid>, ["~> 2.0"])
    s.add_dependency(%q<rspec>, ["~> 2"])
  end
end

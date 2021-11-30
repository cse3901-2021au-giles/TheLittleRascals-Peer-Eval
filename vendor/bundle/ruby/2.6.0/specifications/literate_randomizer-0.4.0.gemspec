# -*- encoding: utf-8 -*-
# stub: literate_randomizer 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "literate_randomizer".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Shane Brinkman-Davis".freeze]
  s.date = "2012-10-28"
  s.description = "A random sentence and paragraph generator gem. Using Markov chains, this generates near-english prose.".freeze
  s.email = ["shanebdavis@gmail.com".freeze]
  s.homepage = "https://github.com/Imikimi-LLC/literate_randomizer".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A random sentence and paragraph generator gem. Using Markov chains, this generates near-english prose.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.6.0"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 2.6.0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 2.6.0"])
  end
end

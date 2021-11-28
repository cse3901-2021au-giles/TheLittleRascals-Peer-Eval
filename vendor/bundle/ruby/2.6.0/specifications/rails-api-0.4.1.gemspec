# -*- encoding: utf-8 -*-
# stub: rails-api 0.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-api".freeze
  s.version = "0.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Santiago Pastorino and Carlos Antonio da Silva".freeze]
  s.date = "2017-03-09"
  s.description = "Rails::API is a subset of a normal Rails application,\n                         created for applications that don't require all\n                         functionality that a complete Rails application provides".freeze
  s.email = ["<santiago@wyeworks.com>".freeze, "<carlosantoniodasilva@gmail.com>".freeze]
  s.executables = ["rails-api".freeze]
  s.files = ["bin/rails-api".freeze]
  s.homepage = "https://github.com/rails-api/rails-api".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Rails for API only Applications".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 3.2.11"])
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.2.11"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.2.11"])
    else
      s.add_dependency(%q<actionpack>.freeze, [">= 3.2.11"])
      s.add_dependency(%q<railties>.freeze, [">= 3.2.11"])
      s.add_dependency(%q<rails>.freeze, [">= 3.2.11"])
    end
  else
    s.add_dependency(%q<actionpack>.freeze, [">= 3.2.11"])
    s.add_dependency(%q<railties>.freeze, [">= 3.2.11"])
    s.add_dependency(%q<rails>.freeze, [">= 3.2.11"])
  end
end

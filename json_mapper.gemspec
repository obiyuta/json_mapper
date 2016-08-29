# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{json_mapper}
  s.version = "0.2.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Trond Arve Nordheim"]
  s.date = %q{2010-08-10}
  s.email = %q{tanordheim@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "Gemfile",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "init.rb",
     "json_mapper.gemspec",
     "lib/json_mapper.rb",
     "lib/json_mapper/attribute.rb",
     "lib/json_mapper/attribute_list.rb",
     "lib/json_mapper/parser.rb",
     "test.rb",
     "test/fixtures/complex.json",
     "test/fixtures/simple.json",
     "test/json_mapper_test.rb",
     "test/support/models.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/tanordheim/json_mapper}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby gem for mapping JSON data structures to Ruby classes}
  s.test_files = [
    "test/support/models.rb",
     "test/test_helper.rb",
     "test/json_mapper_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 1.4.3"])
      s.add_development_dependency(%q<shoulda>, [">= 2.10.3"])
      s.add_development_dependency(%q<mcmire-matchy>, [">= 0.5.2"])
      s.add_development_dependency(%q<mocha>, [">= 0.9.8"])
    else
      s.add_dependency(%q<json>, [">= 1.4.3"])
      s.add_dependency(%q<shoulda>, [">= 2.10.3"])
      s.add_dependency(%q<mcmire-matchy>, [">= 0.5.2"])
      s.add_dependency(%q<mocha>, [">= 0.9.8"])
    end
  else
    s.add_dependency(%q<json>, [">= 1.4.3"])
    s.add_dependency(%q<shoulda>, [">= 2.10.3"])
    s.add_dependency(%q<mcmire-matchy>, [">= 0.5.2"])
    s.add_dependency(%q<mocha>, [">= 0.9.8"])
  end
end

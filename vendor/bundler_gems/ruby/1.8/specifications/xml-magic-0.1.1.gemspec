# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{xml-magic}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Anthony Crumley", "Ben Wyrosdick"]
  s.date = %q{2008-03-15}
  s.description = %q{xml-magic makes accessing xml objects more like any other ruby object}
  s.email = %q{anthony@commonthread.com}
  s.files = ["README", "CHANGELOG", "LICENSE", "demo.rb", "lib/xml_magic.rb", "lib/common_thread/xml/xml_magic.rb", "test/test_helper.rb", "test/test_xml_magic.rb"]
  s.homepage = %q{http://rubyforge.org/projects/xml-magic/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{xml-magic}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{xml-magic makes accessing xml objects more like any other ruby object}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{flickr-fu}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Wyrosdick"]
  s.date = %q{2008-04-10}
  s.email = %q{ben@commonthread.com}
  s.files = ["lib/flickr", "lib/flickr/auth.rb", "lib/flickr/base.rb", "lib/flickr/comment.rb", "lib/flickr/note.rb", "lib/flickr/people.rb", "lib/flickr/person.rb", "lib/flickr/photo.rb", "lib/flickr/photo_response.rb", "lib/flickr/photos.rb", "lib/flickr/size.rb", "lib/flickr/status.rb", "lib/flickr/token.rb", "lib/flickr/uploader.rb", "lib/flickr_fu.rb"]
  s.homepage = %q{http://www.commonthread.com/projects/flickr-fu/rdoc}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{flickr-fu}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Provides a ruby interface to flickr via the REST api}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<xml-magic>, [">= 0"])
    else
      s.add_dependency(%q<xml-magic>, [">= 0"])
    end
  else
    s.add_dependency(%q<xml-magic>, [">= 0"])
  end
end

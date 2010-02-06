# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{machinist}
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pete Yandell"]
  s.date = %q{2009-11-28}
  s.email = %q{pete@notahat.com}
  s.extra_rdoc_files = ["README.markdown"]
  s.files = [".autotest", ".gitignore", "FAQ.markdown", "MIT-LICENSE", "README.markdown", "Rakefile", "VERSION", "init.rb", "lib/machinist.rb", "lib/machinist/active_record.rb", "lib/machinist/blueprints.rb", "lib/machinist/data_mapper.rb", "lib/machinist/object.rb", "lib/machinist/sequel.rb", "lib/sham.rb", "machinist.gemspec", "spec/active_record_spec.rb", "spec/data_mapper_spec.rb", "spec/db/.gitignore", "spec/db/schema.rb", "spec/log/.gitignore", "spec/machinist_spec.rb", "spec/sequel_spec.rb", "spec/sham_spec.rb", "spec/spec_helper.rb"]
  s.homepage = %q{http://github.com/notahat/machinist}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Fixtures aren't fun. Machinist is.}
  s.test_files = ["spec/active_record_spec.rb", "spec/data_mapper_spec.rb", "spec/db/schema.rb", "spec/machinist_spec.rb", "spec/sequel_spec.rb", "spec/sham_spec.rb", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.8"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.8"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.8"])
  end
end

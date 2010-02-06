require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the restful_authentication plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the restful_authentication plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'RestfulAuthentication'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

gemspec = eval(File.read("#{File.dirname(__FILE__)}/restful_authentication.gemspec"))
PKG_NAME = gemspec.name
PKG_VERSION = gemspec.version

Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

desc "Update gemspec from existing one by regenerating path globs specified in *.gemspec.yml or defaults to liberal file globs."
task :gemspec_update  do
  if (gemspec_file = Dir['*.gemspec'][0])
    original_gemspec = eval(File.read(gemspec_file))
    if File.exists?("#{gemspec_file}.yml")
      require 'yaml'
      YAML::load_file("#{gemspec_file}.yml").each do |attribute, globs|
        original_gemspec.send("#{attribute}=", FileList[globs])
      end
    else
      # liberal defaults
      original_gemspec.files = FileList["**/*"]
      test_directories = original_gemspec.test_files.grep(/\//).map {|e| e[/^[^\/]+/]}.compact.uniq
      original_gemspec.test_files = FileList["{#{test_directories.join(',')}}/**/*"] unless test_directories.empty?
    end
    File.open(gemspec_file, 'w') {|f| f.write(original_gemspec.to_ruby) }
    puts "Updated gemspec."
  else
    puts "No existing gemspec file found."
  end
end

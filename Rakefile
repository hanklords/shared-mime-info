require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'

require 'lib/shared-mime-info'

PKG_FILES = FileList["lib/*.rb", "Rakefile", "LICENSE", "README.rdoc"].to_a

spec = Gem::Specification.new do |s|
  s.summary = "Library to guess the MIME type of a file with both filename lookup and magic file detection"
  s.name = "shared-mime-info"
  s.author = "Mael Clerambault"
  s.email =  "mael@clerambault.fr"
  s.version = MIME::VERSION
  s.has_rdoc = true
  s.require_path = 'lib'
  s.files = PKG_FILES
end

Rake::RDocTask.new do |rd|
  rd.rdoc_files.include "README.rdoc", "lib/*.rb"
  rd.options << "--inline-source"
end

Rake::GemPackageTask.new spec do |p|
  p.need_tar_gz = true
end

desc 'Generate the gemspec'
task :spec do
  open("#{spec.name}.gemspec", "w") {|g| g.puts spec.to_ruby }
end

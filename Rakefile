require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'

require 'lib/shared-mime-info'

PKG_FILES = FileList["lib/*.rb", "Rakefile", "LICENSE"].to_a

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
  rd.rdoc_files.include "lib/*.rb"
  rd.options << "--inline-source"
  rd.main = "MIME"
end

Rake::GemPackageTask.new spec do |p|
  p.need_tar_gz = true
end
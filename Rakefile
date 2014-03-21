require 'rspec/core/rake_task'
require 'rake/clean'
RSpec::Core::RakeTask.new('spec')

VER  = '0.0.1'
PROG = 'windirs'
NAME = 'windirs'
LIB  = FileList['lib/*.rb']
BIN  = FileList['bin/*.rb']
TEST = FileList['spec/*.rb']
README = FileList['README.md']
SPEC = "#{PROG}.gemspec"
GEM  = "#{PROG}-#{VER}.gem"
CLEAN.include('doc', '*.gem')

task :all => [:spec, :install]

task :default => :spec

task :test => :spec

task :spec 

file 'doc' => LIB  do
  `rdoc lib/`        #FIXME shell out not cool
end

task :gem => GEM

file GEM => [LIB, BIN, TEST, SPEC, README].flatten do
  `gem build #{SPEC}`            #FIXME shell out not cool
end

task :install => [:install_gem]

task :install_gem => GEM do
  `gem install #{GEM}`            #FIXME shell out not cool
end

task :push do
  `git push origin master`            #FIXME shell out not cool
end

task :publish => :gem do
  `gem push #{GEM}`            #FIXME shell out not cool
end

task :uninstall do
  `gem uninstall #{PROG}`     #FIXME shell out not cool
end

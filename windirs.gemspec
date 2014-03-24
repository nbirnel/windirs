Gem::Specification.new do |s|
  s.name        = 'windirs'
  s.version     = '0.0.2'
  s.date        = '2014-03-24'
  s.summary     = "translate between Cygwin, Windows, and Unix file paths"
  s.description = "Handy ways for dealing with directory paths when you are not
                   sure what platform your code will be running on, but you are
                   sure what platform your code needs to print paths for."
  s.authors     = ['Noah Birnel']
  s.email       = 'nbirnel@gmail.com'
  s.homepage    = 'http://github.com/nbirnel/windirs'
  s.files       = ['README.md', 'windirs.gemspec', 'lib/windirs.rb', 'spec/windirs_spec.rb']
  s.has_rdoc    = true
  s.license     = 'MIT'
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activeadmin_latlng/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin_latlng"
  s.version     = ActiveadminLatlng::VERSION
  s.authors     = ["Alexey Krylov"]
  s.email       = ["alexey2142@mail.ru"]
  s.homepage    = "https://github.com/forsaken1/activeadmin_latlng"
  s.summary     = "ActiveadminLatlng"
  s.description = "Small Active Admin plugin for setting up latitude and longitude."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "activeadmin"

  s.add_development_dependency "rspec"
end

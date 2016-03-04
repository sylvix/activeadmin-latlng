$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activeadmin_latlng/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin_latlng"
  s.version     = ActiveadminLatlng::VERSION
  s.authors     = ["Alexey Krylov"]
  s.email       = ["alexey2142@mail.ru"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActiveadminLatlng."
  s.description = "TODO: Description of ActiveadminLatlng."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "activeadmin"

  s.add_development_dependency "rspec"
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "captchator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "captchator"
  s.version     = Captchator::VERSION
  s.authors     = ["Gabriel Odess-Gillett"]
  s.email       = ["gabeodess@gmail.com"]
  s.homepage    = "https://github.com/gabeodess/captchator"
  s.summary     = "A more readable captcha library alternative to recaptcha."
  s.description = "Due to many unrequited complaints to the recaptcha team with regard to its unreadability for real human users, this gem offers a more readable selection of captcha images."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # s.add_dependency "rails", "~> 3.1.3"

  s.add_development_dependency "sqlite3"
end

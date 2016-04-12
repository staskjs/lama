$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'lama/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'lama'
  s.version     = Lama::VERSION
  s.authors     = ['Stas Karpov']
  s.email       = ['gilbert_90@mail.ru']
  s.homepage    = 'https://github.com/dragothefiery/lama'
  s.summary     = 'Summary of Lama.'
  s.description = 'Description of Lama.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 4.2.6'
  s.add_dependency 'devise', '~> 3.5.6'
  s.add_dependency 'carrierwave', '~> 0.11.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec', '~> 3.0'
end

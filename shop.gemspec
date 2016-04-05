$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'shop/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'shop'
  s.version     = Shop::VERSION
  s.authors     = ['Stas Karpov']
  s.email       = ['gilbert_90@mail.ru']
  s.homepage    = 'https://github.com/dragothefiery/shop'
  s.summary     = 'Summary of Shop.'
  s.description = 'Description of Shop.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.6'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec', '~> 3.0'
end

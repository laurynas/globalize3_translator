$: << File.expand_path('../lib', __FILE__)

require 'globalize/translator/version'

Gem::Specification.new do |s|
  s.name         = 'globalize3_translator'
  s.version      = Globalize::Translator::VERSION
  s.authors      = ['Laurynas Butkus']
  s.email        = 'laurynas.butkus@gmail.com'
  s.homepage     = 'http://github.com/laurynas/globalize3_translator'
  s.summary      = 'Globalize3 auto-translator using Google Translate (or any other backend)'
  s.description  = "#{s.summary}."

  s.files        = Dir['{lib/**/*,[A-Z]*}']
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
  
  s.add_dependency 'activerecord', '>= 3.0.0.rc'
  s.add_dependency 'globalize3', '>= 0.0.7'
  s.add_dependency 'sishen-rtranslate', '>= 1.3'

  s.add_development_dependency 'ruby-debug'
  s.add_development_dependency 'sqlite3-ruby'
end

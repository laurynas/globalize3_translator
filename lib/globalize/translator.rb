require 'globalize/patches/active_record/migration'
require 'globalize/patches/active_record/instance_methods'
require 'globalize/patches/active_record/adapter'
require 'globalize/translator/version'

module Globalize
  module Translator
    autoload :Adapter,         'globalize/translator/adapter'
  end
end

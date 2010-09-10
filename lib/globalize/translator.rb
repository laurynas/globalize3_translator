require 'globalize/patches/core_ext/string'
require 'globalize/patches/active_record/migration'
require 'globalize/patches/active_record/class_methods'
require 'globalize/patches/active_record/instance_methods'
require 'globalize/patches/active_record/adapter'
require 'globalize/patches/active_record/translation'
require 'globalize/translator/version'
require 'globalize/translator/configuration'
require 'globalize/translator/backends/abstract'
require 'globalize/translator/backends/rtranslate'

module Globalize
  module Translator
    autoload :Adapter,         'globalize/translator/adapter'
    
    class << self
      attr_accessor :backend
      
      def configure
        yield(config)
      end
      
      def config
        @config||= Configuration.new        
      end
      
      def backend
        @backend||= config.backend.new
      end
      
      def translatable_locales
        config.locales || I18n.available_locales
      end
      
    end
    
  end
end

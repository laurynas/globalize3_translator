module Globalize
  module Translator
    class Configuration
    
      attr_accessor :backend
      attr_accessor :locales
      
      def initialize
        self.backend = Globalize::Translator::Backends::RTranslate
      end
      
    end
  end
end

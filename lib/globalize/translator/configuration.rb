module Globalize
  module Translator
    class Configuration
    
      attr_accessor :backend
      attr_accessor :locales
      
      def initialize
        
        # default configuration
        self.backend = Backends::RTranslate
        
      end
      
    end
  end
end

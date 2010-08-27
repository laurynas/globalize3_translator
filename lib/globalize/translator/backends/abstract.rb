module Globalize
  module Translator
    module Backends
      
      class Abstract
        
        def translate(value, from_locale, to_locale)
          # override in derived class
          raise "must override in derived class"
        end

      end
      
    end
  end
end

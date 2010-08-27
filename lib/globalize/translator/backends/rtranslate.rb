require 'rtranslate'

module Globalize
  module Translator
    module Backends
      
      class RTranslate < Abstract

        def translate(value, from_locale, to_locale)
          Translate.t(value, from_locale.to_s, to_locale.to_s)
        end
                
      end
      
    end
  end
end

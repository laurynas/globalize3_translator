module Globalize
  module Translator
    class Adapter < Globalize::ActiveRecord::Adapter
      
      def save_translations!
      
        raise 'TODO'
        
        stash.each do |locale, attrs|
          translation = record.translations.find_or_initialize_by_locale(locale.to_s)
          attrs.each { |name, value| translation[name] = value }
          translation.save!
        end
        
        stash.clear
        
      end
      
    end
  end
end

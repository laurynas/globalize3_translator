require 'rtranslate'

module Globalize
  module Translator
    class Adapter < Globalize::ActiveRecord::Adapter
      
      def save_translations!
      
        translate_missing        
        super
        
      end
      
      def translate_missing
        attrs = stash.values.collect(&:keys).sum.uniq
        attrs.each { |attr| translate_attribute(attr) }        
      end
      
      def translate_attribute(attr)
        new_locales = stash.keys.select { |l| translated_attribute?(l, attr) }
        
        from_locale = new_locales.include?(I18n.default_locale) ?
          I18n.default_locale : new_locales.first
          
        from_value  = stash[from_locale][attr]
        
        I18n.available_locales.each do |locale|
          next if translated_attribute?(locale, attr)
          
          #column = record.connection.quote_column_name(column_for_attribute(attr))
          #next if record.translations.exists?([ "locale=? AND #{column} IS NOT NULL", locale ])
          
          value               = Translate.t(from_value, from_locale.to_s, locale.to_s)
          stash[locale][attr] = value unless value.nil?
                    
        end   
      end
      
      def translated_attribute?(locale, attr)
        return false if stash[locale].nil?
        return !stash[locale][attr].nil?
      end
      
    end
  end
end

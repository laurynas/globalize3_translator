module Globalize
  module Translator
    class Adapter
      attr_reader :record, :backend

      delegate    :globalize, :to => :record
      delegate    :stash,     :to => :globalize
            
      def initialize(record)
        @record     = record
        @backend    = Globalize::Translator::Backends::RTranslate.new
      end
      
      def translate
        attrs = stash.values.collect(&:keys).sum.uniq
        attrs.each { |attr| translate_attribute(attr) }        
      end
      
      def translate_attribute(name)
        new_locales = stash.keys.select { |l| translated_attribute?(l, name) }
        
        from_locale = new_locales.include?(I18n.default_locale) ?
          I18n.default_locale : new_locales.first
          
        from_value  = stash[from_locale][name]
        
        translatable_locales.each do |locale|
          next if translated_attribute?(locale, name)
          
          #column = record.connection.quote_column_name(column_for_attribute(attr))
          #next if record.translations.exists?([ "locale=? AND #{column} IS NOT NULL", locale ])
          
          value               = backend.translate(from_value, from_locale.to_s, locale.to_s)
          stash[locale][name] = value unless value.nil?
                    
        end   
      end
      
      def translated_attribute?(locale, name)
        return false if stash[locale].nil?
        return !stash[locale][name].nil?
      end
      
      protected
      
      def translatable_locales
        I18n.available_locales
      end
      
    end
  end
end

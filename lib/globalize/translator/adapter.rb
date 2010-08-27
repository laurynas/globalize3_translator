module Globalize
  module Translator
    class Adapter
      attr_reader :record

      delegate    :globalize, :to => :record
      delegate    :stash,     :to => :globalize
            
      def initialize(record)
        @record     = record
      end
      
      def translate
        attrs = stash.values.collect(&:keys).sum.uniq
        attrs.each { |name| translate_attribute(name) }        
      end
      
      def translate_attribute(name)
        from_locale = get_source_locale(name)
        from_value  = stash.read(from_locale, name)
        
        translatable_locales.each do |locale|
          next unless translate?(locale, name)
          
          value = backend.translate(from_value, from_locale, locale)
          
          unless value.nil?
            stash.write(locale, name, value)
            value.auto_translated = true
          end
        end   
      end
      
      protected

      def manual_in_stash?(locale, name)
        value = stash.read(locale, name)
        !value.nil? && !value.auto_translated?
      end

      def translate?(locale, name)
        #column = record.connection.quote_column_name(column_for_attribute(attr))
        #next if record.translations.exists?([ "locale=? AND #{column} IS NOT NULL", locale ])
          
        !manual_in_stash?(locale, name)
      end
      
      def get_source_locale(name)
        locales = stash.keys.select { |locale| manual_in_stash?(locale, name) }
        locales.include?(I18n.default_locale) ? I18n.default_locale : locales.first
      end
      
      def backend
        Globalize::Translator.backend
      end
      
      def translatable_locales
        I18n.available_locales
      end
      
    end
  end
end

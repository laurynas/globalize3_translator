require 'globalize/active_record/class_methods'

Globalize::ActiveRecord::ClassMethods.class_eval do
  def translation_class_with_auto
    klass = translation_class_without_auto
    klass.handle_auto_translated_attributes(translated_attribute_names)    
    klass
  end
  
  alias_method_chain :translation_class, :auto
end

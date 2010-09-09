require 'globalize/active_record/class_methods'

Globalize::ActiveRecord::ClassMethods.class_eval do
  def translation_class_with_auto
    klass = translation_class_without_auto
    translated_attribute_names.each { |attr_name| klass.auto_translated_attr_accessor(attr_name) }
    klass
  end
  
  alias_method_chain :translation_class, :auto
end

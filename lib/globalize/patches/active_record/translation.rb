require 'globalize/active_record/translation'

Globalize::ActiveRecord::Translation.class_eval do

  class << self
    cattr_accessor :auto_attributes
    
    def handle_auto_translated_attributes(attribute_names)
      self.auto_attributes = attribute_names
      self.auto_attributes.each { |attr_name| self.auto_translated_attr_accessor(attr_name) }
    end
    
    def auto_translated_attr_accessor(name)
      define_method(name) do |*args|
        read_auto_translated_attribute(name)
      end
    end
  end
  
  def read_auto_translated_attribute(name)
    val = read_attribute(name)
    
    if val && val.auto_translated.nil?
      val.auto_translated = read_attribute(auto_marker_name(name))
    end
    
    val
  end
  
  def write_attribute(attr_name, value)
    if self.class.auto_attributes.include?(attr_name.to_sym)
      marker_name = auto_marker_name(attr_name)
      
      if value
        self[marker_name] = value.auto_translated?
      else
        self[marker_name] = nil
      end
    end
    
    super
  end
  
  def auto_marker_name(field_name)
    "#{field_name}_auto_translated"
  end
  
end

require 'globalize/active_record/translation'

Globalize::ActiveRecord::Translation.class_eval do

  before_validation :set_auto_translations

  class << self
    def auto_field_markers
      @auto_field_markers||= column_names.select { |c| c.match(/_auto_translated$/) }      
    end
    
    def auto_field_targets
      @auto_field_targets||= auto_field_markers.collect { |n| marker_target(n) }
    end
    
    def marker_target(marker_name)
      marker_name.gsub("_auto_translated", "")
    end
    
    def marker_name_for_target(field_name)
      "#{field_name}_auto_translated"
    end
    
    def auto_translated_attr_accessor(name)
      #define_method(:"#{name}=") do |value|
      #  write_auto_translated_attribute(name, value)
      #end
      
      define_method(name) do |*args|
        read_auto_translated_attribute(name)
      end
    end
  end
  
  def read_auto_translated_attribute(name)
    val = read_attribute(name)
    
    if val && val.auto_translated.nil?
      val.auto_translated = read_attribute("#{name}_auto_translated")
    end
    
    val
  end
  
  private
  
  def set_auto_translations
  
    self.class.auto_field_markers.each do |marker_name|     
      value = self[self.class.marker_target(marker_name)]
      self[marker_name] = value.auto_translated? if value
    end
    
    true
    
  end
  
end

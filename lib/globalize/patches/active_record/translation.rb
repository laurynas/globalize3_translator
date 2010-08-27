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
  end  
  
  def title
    val = super
    
    if val && val.auto_translated.nil?
      val.auto_translated = title_auto_translated 
    end
    
    val    
  end
  
  def content
    val = super
    
    if val && val.auto_translated.nil?
      val.auto_translated = content_auto_translated 
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

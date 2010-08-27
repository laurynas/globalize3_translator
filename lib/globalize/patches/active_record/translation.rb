require 'globalize/active_record/translation'

Globalize::ActiveRecord::Translation.class_eval do

  before_validation :set_auto_translations

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
    
    self.title_auto_translated   = title.auto_translated?    if title
    self.content_auto_translated = content.auto_translated?  if content
    
    true
    
  end
  
end

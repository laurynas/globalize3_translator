require 'globalize/active_record/instance_methods'

Globalize::ActiveRecord::InstanceMethods.class_eval do

  def globalize_translator
    @globalize_translator||= Globalize::Translator::Adapter.new(self)
  end

end

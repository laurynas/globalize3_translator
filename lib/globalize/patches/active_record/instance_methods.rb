require 'globalize/active_record/instance_methods'

Globalize::ActiveRecord::InstanceMethods.class_eval do

  def globalize_with_auto
    @globalize ||= Globalize::Translator::Adapter.new(self)
  end

  alias_method_chain :globalize, :auto

end

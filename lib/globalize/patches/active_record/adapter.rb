require 'globalize/active_record/adapter'

Globalize::ActiveRecord::Adapter.class_eval do

  delegate :automated, :to => :'record.globalize_translator'

  def save_translations_with_auto!
    record.globalize_translator.translate
    save_translations_without_auto!
  end

  alias_method_chain :save_translations!, :auto

end

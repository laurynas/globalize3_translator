require 'globalize/active_record/migration'

Globalize::ActiveRecord::Migration::Migrator.class_eval do

  def create_translation_table_with_auto
    create_translation_table_without_auto
    connection.add_column translations_table_name, :auto, :boolean
  end

  alias_method_chain :create_translation_table, :auto

end

require 'globalize/active_record/migration'

Globalize::ActiveRecord::Migration::Migrator.class_eval do

  def create_translation_table_with_auto
    create_translation_table_without_auto
    
    # add auto translation indicators
    fields.each do |name, type|
      field_name = "#{name}_auto_translated"
      connection.add_column translations_table_name, field_name, :boolean  
    end    
  end

  alias_method_chain :create_translation_table, :auto

end

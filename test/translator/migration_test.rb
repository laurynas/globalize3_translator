require 'test_helper'

class MigrationTest < ActiveSupport::TestCase
  
  setup do 
    assert !Migrated::Translation.table_exists?
  end
  
  test "Must have auto column" do
    Migrated.create_translation_table! :name => :text
    assert_migration_table(:name => :text)
  end

  protected
   
    def column_type(name)
      Migrated::Translation.columns.detect { |c| c.name == name.to_s }.try(:type)      
    end
  
    def assert_migration_table(fields)
      assert Migrated::Translation.table_exists?
      assert Migrated::Translation.index_exists_on?(:migrated_id)
  
      assert_equal :string,   column_type(:locale)
      assert_equal :integer,  column_type(:migrated_id)
      assert_equal :datetime, column_type(:created_at)
      assert_equal :datetime, column_type(:updated_at)
    
      fields.each do |name, type|
        assert_equal type, column_type(name)
        assert_equal :boolean, column_type("#{name}_auto_translation")
      end
    end  
end

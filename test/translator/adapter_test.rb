require 'test_helper'

class AdapterTest < ActiveSupport::TestCase

  setup do
    I18n.locale = :en
    
    assert_equal I18n.locale, :en
  end
  
  test "Record should include translator adapter" do
    assert_kind_of Globalize::Translator::Adapter, Post.new.globalize_translator
  end

end

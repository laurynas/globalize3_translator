require 'test_helper'

class TranslatorTest < ActiveSupport::TestCase

  setup do
    I18n.locale = :en
    
    assert_equal I18n.locale, :en
  end
  
  test "Should include version" do 
    assert_kind_of String, Globalize::Translator::VERSION
  end
  
  test "Should include adapter" do
    assert Globalize::Translator::Adapter
  end
  
  test "Should use translator adapter" do
    assert_kind_of Globalize::Translator::Adapter, Post.new.globalize
  end
  
  test "Should accept & store translations" do 
    @post       = Post.new
    @post.title = "First"
    
    I18n.locale = :lt
    
    @post.title = "Pirmas"
    @post.save!
    @post.reload
    
    assert_equal @post.title, "Pirmas"
    
    I18n.locale = :en
    
    assert_equal @post.title, "First"    
  end
  
end

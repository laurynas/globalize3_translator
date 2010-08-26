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
    post       = Post.new
    post.title = "First"
    
    I18n.locale = :lt
    
    post.title = "Pirmas"
    
    assert post.save!
    assert post.reload
    
    assert_equal post.title, "Pirmas"
    
    I18n.locale = :en
    
    assert_equal post.title, "First"    
  end
  
  test "Should translate data from default locale when saving" do
    I18n.locale = :en
    
    post = Post.new( :title => "Dog", :content => "Cat" )
    
    assert post.save!
    assert post.reload
    
    assert_equal post.title,    "Dog"
    assert_equal post.content,  "Cat"
    
    I18n.locale = :lt
    
    assert_equal post.title,    "Šuo"
    assert_equal post.content,  "Katė"
    
    I18n.locale = :cs
    
    assert_equal post.title,    "Pes"
  end
  
end

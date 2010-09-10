require 'test_helper'

class TranslatorTest < ActiveSupport::TestCase

  setup do
    I18n.locale = :en
    
    assert_equal I18n.locale, :en
  end
  
  test "Should include version" do 
    assert_kind_of String, Globalize::Translator::VERSION
  end
  
  test "Should return backend" do
    assert Globalize::Translator.backend
  end
  
  test "Should accept & store translations" do 
    post       = Post.new
    post.title = "First"
    
    I18n.locale = :lt
    
    post.title = "Pirmas"
    
    assert post.save!
    assert post.reload
    
    assert_equal "Pirmas",      post.title
    
    I18n.locale = :en
    
    assert_equal "First",       post.title
  end
  
  test "Should translate data from default locale when saving" do
    post = Post.new( :title => "Dog", :content => "Cat" )
    
    assert post.save!
    assert post.reload
    
    assert_equal "Dog",         post.title
    assert_equal "Cat",         post.content
    assert !post.title.auto_translated?
    assert !post.content.auto_translated?
    
    I18n.locale = :lt
    
    assert_equal "Šuo",         post.title
    assert_equal "Katė",        post.content
    assert post.title.auto_translated?
    assert post.content.auto_translated?
    
    I18n.locale = :cs
    
    assert_equal "Pes",         post.title
    assert post.title.auto_translated?
  end
  
  test "Modifying model" do
    post = Post.new( :title => "Dog", :content => "Cat" )
    assert post.save!
    
    assert post = Post.find(:last)
    
    I18n.locale = :lt
    
    assert_equal "Šuo", post.title
    assert post.title.auto_translated?
    
    post.title = "Vilkas"
    
    assert_equal "Vilkas", post.title
    assert !post.title.auto_translated?
    
    assert post.save!
    
    assert post = Post.find(:last)
    
    assert !post.title.auto_translated?
    
    I18n.locale = :en
    
    assert_equal "Wolf", post.title
    assert post.title.auto_translated?
    
    I18n.locale = :cs
    
    assert_equal "Vlk", post.title
    assert post.title.auto_translated?
  end
  
end

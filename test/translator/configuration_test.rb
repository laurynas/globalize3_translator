require 'test_helper'

class ConfigurationTest < ActiveSupport::TestCase

  test "Should have config" do 
    assert_instance_of Globalize::Translator::Configuration, Globalize::Translator.config    
  end
  
  test "Should have default backend" do
    assert_kind_of Class, Globalize::Translator.config.backend
  end
  
  test "Should translate all locales by default" do
    assert_respond_to Globalize::Translator.config, :locales
    assert_nil        Globalize::Translator.config.locales
    assert_same       I18n.available_locales, Globalize::Translator.translatable_locales
  end
  
  test "Should configure" do
    Globalize::Translator.configure do |config|
      config.locales = []
    end
    
    assert_equal [], Globalize::Translator.translatable_locales
    
    Globalize::Translator.config.locales = nil
    
    assert_nil Globalize::Translator.config.locales
  end
  
end

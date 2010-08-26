require 'test_helper'
require 'rtranslate'

class RTranslateTest < ActiveSupport::TestCase
  
  test "Translation" do
    assert_equal Translate.t('Dog', 'en', 'lt'), 'Šuo'
    assert_equal Translate.t('Katė', 'lt', 'en'), 'Cat'
    assert_equal Translate.t('Šuo', 'lt', 'cs'), 'Pes'
    assert_equal Translate.t('Wild cat', 'en', 'lt'), 'Laukinė katė'
  end
  
end

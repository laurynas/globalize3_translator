require 'test_helper'

class BackendsTest < ActiveSupport::TestCase

  test "Abstract backend should require to override" do
    backend = Globalize::Translator::Backends::Abstract.new
    
    assert_raise RuntimeError do
      backend.translate('Dog', :en, :lt)
    end
  end
  
  test "RTranslate backend" do
    backend = Globalize::Translator::Backends::RTranslate.new
    
    assert_equal backend.translate('Dog', :en, :lt), 'Šuo'
  end

end

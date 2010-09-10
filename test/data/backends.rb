class MyTranslatorBackend < Globalize::Translator::Backends::Abstract

  def translate(value, from_locale, to_locale)
    "test #{to_locale} #{value}"          
  end
          
end

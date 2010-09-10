require 'rubygems'
require 'bundler'
require 'test/unit'
require 'active_support'

Bundler.require(:default, :test)

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

require 'globalize/translator'
require 'data/schema'
require 'data/models'
require 'data/backends'

# add test locales
I18n.load_path += Dir.glob(File.dirname(__FILE__) + '/data/locales/*.yml')

ActiveRecord::Base.class_eval do
  class << self
    def index_exists?(index_name)
      connection.indexes(table_name).any? { |index| index.name == index_name.to_s }
    end

    def index_exists_on?(column_name)
      connection.indexes(table_name).any? { |index| index.columns == [column_name.to_s] }
    end
  end
end

class Test::Unit::TestCase
  def teardown
    Globalize::Translator.backend = nil
  end
end

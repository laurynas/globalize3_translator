ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :blogs, :force => true do |t|
    t.string   :description
  end

  create_table :posts, :force => true do |t|
    t.references :blog
    # t.boolean    :published
  end

  create_table :post_translations, :force => true do |t|
    t.string     :locale
    t.references :post
    t.string     :title
    t.text       :content
    t.boolean    :published
    t.datetime   :published_at
    t.boolean    :title_auto_translated
    t.boolean    :content_auto_translated
  end

  create_table :parents, :force => true do |t|
  end

  create_table :parent_translations, :force => true do |t|
    t.string     :locale
    t.references :parent
    t.text       :content
    t.string     :type
    
    t.boolean    :content_auto_translated
  end

  create_table :comments, :force => true do |t|
    t.references :post
  end

  create_table :comment_translations, :force => true do |t|
    t.string     :locale
    t.references :comment
    t.string     :title
    t.text       :content

    t.boolean    :title_auto_translated
    t.boolean    :content_auto_translated
  end

  create_table :migrateds, :force => true do |t|
    t.string :name
    t.string :untranslated
  end

  create_table :validatees, :force => true do |t|
  end

  create_table :validatee_translations, :force => true do |t|
    t.references :validatee
    t.string     :locale
    t.string     :string
    t.boolean    :string_auto_translated
  end

  create_table :users, :force => true do |t|
    t.string :email
  end

  create_table :user_translations, :force => true do |t|
    t.references :user
    t.string     :locale
    t.string     :name
    t.boolean    :name_auto_translated    
  end
end

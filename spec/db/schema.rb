ActiveRecord::Schema.define(:version => 0) do
  create_table :posts, :force => true do |t|
    t.column :title, :string
    t.column :body, :string
    t.column :subject, :string
    t.column :author_id, :integer
  end
  create_table :comments, :force => true do |t|
    t.column :title, :string
    t.column :body, :string
    t.column :subject, :string
    t.column :author_id, :integer
  end
  create_table :authors, :force => true do |t|
    t.column :name, :string
  end
end

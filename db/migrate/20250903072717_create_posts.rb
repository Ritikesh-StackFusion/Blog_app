class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :author
      t.string :category
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end

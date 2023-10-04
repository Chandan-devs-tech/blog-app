class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :author, foreign_key: { to_table: :users }
      t.string :title
      t.string :text
      t.integer :comments_counter
      t.integer :likes_counter

      t.timestamps
    end
  end
end

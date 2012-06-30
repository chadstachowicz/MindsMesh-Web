class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :topic
      t.references :user
      t.text :text
      t.integer :likes_count, default: 0
      t.integer :replies_count, default: 0

      t.timestamps
    end
    add_index :posts, :topic_id
    add_index :posts, :user_id
  end
end

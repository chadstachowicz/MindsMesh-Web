class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.references :post
      t.references :user
      t.text :text
      t.integer :likes_count, default: 0

      t.timestamps
    end
    add_index :replies, :post_id
    add_index :replies, :user_id
  end
end

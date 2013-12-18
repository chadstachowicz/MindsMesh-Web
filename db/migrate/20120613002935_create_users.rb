class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :gender
      t.string   :fb_id
      t.string   :fb_token
      t.datetime :fb_expires_at
      t.integer :roles_mask, default: 0
      t.integer :posts_count, default: 0
      t.integer :replies_count, default: 0
      t.integer :likes_count, default: 0
      t.integer :topic_users_count, default: 0

      t.timestamps
    end
  end
end

class CreateFbFriends < ActiveRecord::Migration
  def change
    create_table :fb_friends do |t|
      t.references :user
      t.integer :friend_user_id
      t.string :fb_id
      t.boolean :b_studying
      t.boolean :b_same_school
      t.datetime :last_request_sent_at

      t.timestamps
    end
    add_index :fb_friends, :user_id
    add_index :fb_friends, :friend_user_id
  end
end

class AddMessagingDbChanges < ActiveRecord::Migration
  def up
      create_table :threads do |t|
          t.timestamps
      end
      create_table :thread_participants do |t|
          t.integer :user_id
          t.integer :thread_id
          t.timestamps
      end
      create_table :message_read_states do |t|
          t.integer :user_id
          t.integer :message_id
          t.datetime :read_date
          t.timestamps
      end
      rename_column :messages, :receiver_id, :thread_id
      remove_column :messages, :receiver_fb_id
      remove_column :messages, :expired
      remove_column :messages, :expiration_date
  end

  def down
  end
end

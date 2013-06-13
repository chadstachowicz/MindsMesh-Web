class AddToThreadToMessages2 < ActiveRecord::Migration
  def change
      rename_column :thread_participants, :thread_id, :message_thread_id
      add_column :messages, :message_thread_id, :integer
  end
end

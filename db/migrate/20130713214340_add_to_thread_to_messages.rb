class AddToThreadToMessages < ActiveRecord::Migration
  def change
      rename_table :threads, :message_threads
  end
end

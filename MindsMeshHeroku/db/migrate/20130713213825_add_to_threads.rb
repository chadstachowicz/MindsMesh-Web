class AddToThreads < ActiveRecord::Migration
  def up
      add_column :threads, :user_id, :integer
  end

  def down
  end
end

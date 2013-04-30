class AddTwitIdToUser < ActiveRecord::Migration
  def change
      add_column :users, :twit_id, :integer
  end
end

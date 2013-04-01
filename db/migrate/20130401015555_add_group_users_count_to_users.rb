class AddGroupUsersCountToUsers < ActiveRecord::Migration
  def change
      add_column :users, :group_users_count, :integer
  end
end

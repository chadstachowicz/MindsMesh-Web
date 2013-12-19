class ChangeRoleNames < ActiveRecord::Migration
  def up
      rename_column :group_users, :role, :role_i
      rename_column :topic_users, :role, :role_i
      change_column :group_users, :role_i, :integer
      change_column :topic_users, :role_i, :integer
  end

  def down
  end
end

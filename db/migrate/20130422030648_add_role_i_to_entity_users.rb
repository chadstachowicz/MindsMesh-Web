class AddRoleIToEntityUsers < ActiveRecord::Migration
  def change
      add_column :entity_users, :role_i, :integer
  end
end

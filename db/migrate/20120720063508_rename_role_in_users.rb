class RenameRoleInUsers < ActiveRecord::Migration
  def up
  	change_table :users do |t|
      t.rename :roles_mask, :role_i
    end
    User.update_all role_i: 0
  end
  def down
  	change_table :users do |t|
      t.rename :roles_mask, :role_i
    end
    User.update_all roles_mask: 0
  end
end

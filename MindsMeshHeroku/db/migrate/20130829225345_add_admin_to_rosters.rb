class AddAdminToRosters < ActiveRecord::Migration
  def change
      add_column :rosters, :role, :integer
  end
end

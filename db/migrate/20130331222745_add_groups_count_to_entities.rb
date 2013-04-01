class AddGroupsCountToEntities < ActiveRecord::Migration
  def change
      add_column :entities, :groups_count, :integer
  end
end

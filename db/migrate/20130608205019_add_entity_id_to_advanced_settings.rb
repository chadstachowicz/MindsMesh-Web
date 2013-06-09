class AddEntityIdToAdvancedSettings < ActiveRecord::Migration
  def change
      add_column :entity_advanced_settings, :entity_id, :integer
  end
end

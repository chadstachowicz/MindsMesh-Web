class ChangeEntityLms < ActiveRecord::Migration
  def up
      rename_column :entity_user_lms, :lms_provider_id, :entity_lms_provider_id
  end

  def down
  end
end

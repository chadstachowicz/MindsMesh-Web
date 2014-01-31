class ChangeEntityLms2 < ActiveRecord::Migration
  def up
      rename_column :entity_user_lms, :entity_lms_provider_id, :entity_lms_id
  end

  def down
  end
end

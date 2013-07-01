class AddEntityLmsToTopic < ActiveRecord::Migration
  def change
      add_column :topics, :entity_lms_id, :integer
  end
end

class AddMoodleUrlToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :moodle_url, :string
  end
end

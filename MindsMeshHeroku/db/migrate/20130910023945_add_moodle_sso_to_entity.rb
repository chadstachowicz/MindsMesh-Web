class AddMoodleSsoToEntity < ActiveRecord::Migration
  def change
      add_column :entities, :moodle_sso, :integer
  end
end

class CreateEntityUserLms < ActiveRecord::Migration
  def change
    create_table :entity_user_lms do |t|
      t.integer :lms_provider_id
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end

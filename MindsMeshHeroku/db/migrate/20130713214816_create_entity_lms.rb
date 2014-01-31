class CreateEntityLms < ActiveRecord::Migration
  def change
    create_table :entity_lms do |t|
      t.integer :lms_provider_id
      t.integer :entity_id
      t.string :version
      t.string :host
      t.integer :secure
      t.string :lti_guid

      t.timestamps
    end
  end
end

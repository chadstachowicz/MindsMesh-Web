class CreateEntityAdvancedSettings < ActiveRecord::Migration
  def change
    create_table :entity_advanced_settings do |t|
      t.string :lti_consumer_key
      t.string :lti_consumer_secret
        t.integer :lms_provider
        t.integer :can_create_topic
        

      t.timestamps
    end
  end
end

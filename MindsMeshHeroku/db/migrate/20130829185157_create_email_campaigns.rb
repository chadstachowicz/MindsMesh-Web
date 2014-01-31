class CreateEmailCampaigns < ActiveRecord::Migration
  def change
    create_table :email_campaigns do |t|
      t.string :name
      t.string :type
      t.integer :entity_id
      t.integer :emails_sent
      t.integer :emails_responded
      t.string :status

      t.timestamps
    end
  end
end

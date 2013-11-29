
# MindsMesh, Inc. (c) 2012-2013

class CreateAdminCampaignsUsers < ActiveRecord::Migration
  def change
    create_table :admin_campaigns_users do |t|
      t.references :admin_campaign
      t.references :user
      t.boolean    :delivered   # already sent = true or not
      t.integer    :entity_id

      t.timestamps
    end
    add_index :admin_campaigns_users, :admin_campaign_id
    add_index :admin_campaigns_users, :user_id
  end
end

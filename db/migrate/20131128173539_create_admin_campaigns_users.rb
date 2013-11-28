
# MindsMesh, Inc. (c) 2012-2013

class CreateAdminCampaignsUsers < ActiveRecord::Migration
  def change
    create_table :admin_campaigns_users do |t|
      t.references :admin_campaign
      t.references :user
      t.boolean :delivered   # scheduled = true or not
       
      t.timestamps
    end
    add_index :admin_campaigns_users, :admin_campaign_id
    add_index :admin_campaigns_users, :user_id
  end
end

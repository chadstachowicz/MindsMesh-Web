
# MindsMesh, Inc. (c) 2012-2013

class CreateAdminCampaignAttrs < ActiveRecord::Migration
  def change
    create_table :admin_campaign_attrs do |t|
      t.references :admin_campaign
      t.integer :entity_id
      t.string :key
      t.integer :value

      t.timestamps
    end
    add_index :admin_campaign_attrs, :admin_campaign_id
  end
end

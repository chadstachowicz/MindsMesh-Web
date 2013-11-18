
# MindsMesh, Inc. (c) 2012-2013

# rails g scaffold admin/Campaigns kind:string historic:boolean user:references newsletter:references entity:references 

class CreateAdminCampaigns < ActiveRecord::Migration
  def change
    create_table :admin_campaigns do |t|
      t.string :kind
      t.boolean :historic
      t.references :newsletter
      t.references :entity

      t.timestamps
    end
    add_index :admin_campaigns, :newsletter_id, :entity_id
  end
end

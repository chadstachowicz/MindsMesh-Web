
# MindsMesh, Inc. (c) 2012-2013

# rails g scaffold admin/Campaigns group:string, value:string, historic:boolean, newsletter:references 

class CreateAdminCampaigns < ActiveRecord::Migration
  def change
    create_table :admin_campaigns do |t|
      t.string :kind
      t.string :value
      t.integer :element_id
      t.boolean :historic
      t.references :newsletter

      t.timestamps
    end
    add_index :admin_campaigns, :newsletter_id
  end
end

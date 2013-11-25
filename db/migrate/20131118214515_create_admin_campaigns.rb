
# MindsMesh, Inc. (c) 2012-2013

class CreateAdminCampaigns < ActiveRecord::Migration
  def change
    create_table :admin_campaigns do |t|
      t.string :kind
      t.boolean :historic
      t.references :user, index: true
      t.references :newsletter, index: true
      t.references :entity, index: true

      t.timestamps
    end
  end
end

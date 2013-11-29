
# MindsMesh, Inc. (c) 2012-2013

class CreateAdminCampaigns < ActiveRecord::Migration
  def change
    create_table :admin_campaigns do |t|
      t.string :kind
      t.integer :scheduled       # scheduled = true or not
      t.boolean :delivered       # delivered = true or not
      t.timestamps :futuretime   # when mthe email, will be send
      t.references :newsletter, index: true

      t.timestamps
    end
  end
end

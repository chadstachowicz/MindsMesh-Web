
# MindsMesh, Inc. (c) 2012-2013

class CreateAdminCampaigns < ActiveRecord::Migration
  def change
    create_table :admin_campaigns do |t|
      t.string :kind
      t.boolean :scheduled   # scheduled = true or not
      t.boolean :delivered   # scheduled = true or not
      # t.integer :type        # 1 = 24 hours, 2=croned 
      t.timestamps :futuretime  # when the email, will be send
      t.references :user, index: true
      t.references :newsletter, index: true
      t.references :entity, index: true

      t.timestamps
    end
  end
end

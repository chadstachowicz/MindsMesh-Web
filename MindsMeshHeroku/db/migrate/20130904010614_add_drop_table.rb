class AddDropTable < ActiveRecord::Migration
  def up
      drop_table :background_jobs
      
      create_table :background_jobs do |t|
          t.string :name
          t.string :type
          t.integer :entity_id
          t.integer :transactions
          t.integer :total_records
          t.integer :campaign_id
          t.string :status
          
          t.timestamps
      end
  end

  def down
  end
end

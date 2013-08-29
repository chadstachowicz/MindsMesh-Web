class CreateBackgroundJobs < ActiveRecord::Migration
  def change
    create_table :background_jobs do |t|
      t.string :name
      t.string :type
      t.integer :entity_id
      t.integer :transactions
      t.integer :campaign_id
      t.string :status

      t.timestamps
    end
  end
end

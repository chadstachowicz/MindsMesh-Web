class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.integer :entity_id
      t.string :name

      t.timestamps
    end
  end
end

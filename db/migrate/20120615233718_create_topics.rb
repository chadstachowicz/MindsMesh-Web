class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.belongs_to :entity
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :topics, :entity_id
  end
end

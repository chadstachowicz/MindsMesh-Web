class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.belongs_to :entity
      t.string :name
      t.string :slug
      t.integer :topic_users_count, default: 0
      t.integer :posts_count, default: 0

      t.timestamps
    end
    add_index :topics, :entity_id
  end
end

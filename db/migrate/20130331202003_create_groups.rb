class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :entity_id
      t.string :name
      t.string :slug
      t.integer :group_users_count, :default => 0
      t.integer :posts_count, :default => 0
      t.string :description
      t.integer :user_id
      t.integer :privacy, :default => 0

      t.timestamps
    end
  end
end

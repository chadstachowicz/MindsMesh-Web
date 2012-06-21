class CreateEntityUsers < ActiveRecord::Migration
  def change
    create_table :entity_users do |t|
      t.belongs_to :entity
      t.belongs_to :user

      t.timestamps
    end
    add_index :entity_users, :entity_id
    add_index :entity_users, :user_id
  end
end

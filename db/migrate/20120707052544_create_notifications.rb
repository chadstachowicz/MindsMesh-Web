class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user
      t.boolean :b_read, default: false
      t.string :action
      t.integer :target_id
      t.string :target_type
      t.integer :actors_count, default: 0
      t.string :text

      t.timestamps
    end
    add_index :notifications, :user_id
    add_index :notifications, [:target_type, :target_id]
  end
end

class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user
      t.string :likable_type
      t.integer :likable_id

      t.timestamps
    end
    add_index :likes, [:likable_type, :likable_id] #by post (or reply)
    add_index :likes, [:user_id]                   #by user
    add_index :likes, [:user_id, :likable_type]    #by user and type
  end
end

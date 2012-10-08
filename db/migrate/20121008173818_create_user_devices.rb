class CreateUserDevices < ActiveRecord::Migration
  def change
    create_table :user_devices do |t|
      t.references :user
      t.string :os
      t.string :model
      t.string :name
      t.string :token
      t.string :environment

      t.timestamps
    end
    add_index :user_devices, :user_id
    add_index :user_devices, [:user_id, :token]
  end
end

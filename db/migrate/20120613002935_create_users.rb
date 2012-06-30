class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo_url
      t.integer :roles_mask, default: 0

      t.timestamps
    end
  end
end

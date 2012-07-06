class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.belongs_to :user
      t.string :provider
      t.string :uid
      t.string :permissions_s
      t.text :auth_s

      t.timestamps
    end
    add_index :logins, :user_id
  end
end

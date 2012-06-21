class CreateEntityUserRequests < ActiveRecord::Migration
  def change
    create_table :entity_user_requests do |t|
      t.belongs_to :entity
      t.belongs_to :user
      t.string :email
      t.string :confirmation_token
      t.datetime :last_email_sent_at

      t.timestamps
    end
    add_index :entity_user_requests, :entity_id
    add_index :entity_user_requests, :user_id
  end
end

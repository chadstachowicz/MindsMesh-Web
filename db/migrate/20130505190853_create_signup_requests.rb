class CreateSignupRequests < ActiveRecord::Migration
  def change
    create_table :signup_requests do |t|
      t.integer :entity_id
      t.integer :user_id
      t.string :email
      t.string :confirmation_token
      t.datetime :last_email_sent_at
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
